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

resource "aws_s3_bucket_acl" "bucket-acl" {
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

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
        }
    ]
}
POLICY
}



