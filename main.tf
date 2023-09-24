terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


# --------------------------------------------------------------------------
# Static website hosted on S3
# --------------------------------------------------------------------------
resource "aws_s3_bucket" "website" {
  bucket        = var.static_website_bucket_name
  force_destroy = true

  tags = {
    Name = var.tag_name
  }
}

resource "aws_s3_bucket_ownership_controls" "website_ownership" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "website_public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.website_ownership,
    aws_s3_bucket_public_access_block.website_public_access,
  ]

  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3_website_config" {
  bucket = aws_s3_bucket.website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_policy" "s3_website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
  }
}


# --------------------------------------------------------------------------
# ACM Certificate
# --------------------------------------------------------------------------
resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "ACM Certificate for ${var.domain_name}"
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {

  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for rvo in aws_route53_record.validation : rvo.fqdn]
}

# --------------------------------------------------------------------------
# CloudFront Distribution
# --------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website.bucket
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${aws_s3_bucket.website.bucket}"
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.website.bucket

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = var.price_class


  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restriction_type == "none" ? [] : var.restriction_locations
    }

  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.main.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

  tags = {
    Name = "CloudFront Distribution for ${aws_s3_bucket.website.bucket}"
  }
}


# --------------------------------------------------------------------------
# Route 53
# --------------------------------------------------------------------------

data "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.domain_prefix}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "AAAA_main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "AAAA_www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.domain_prefix}.${var.domain_name}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
