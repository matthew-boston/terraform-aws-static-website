provider "aws" {
  region = "us-east-1"
}

module "static-website" {
  source  = "matthew-boston/static-website/aws"
  version = "1.1.1"
  # insert the 3 required variables here
  static_website_bucket_name = "example.com"
  tag_name                   = "tag_name"
  domain_name                = "example.com"
  # Optional
  domain_prefix              = "www"
  restriction_type           = "blacklist"
  restriction_locations      = ["CN", "RU"]
}