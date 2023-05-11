output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "s3_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}

output "website_address" {
  value = var.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.id
}