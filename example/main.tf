provider "aws" {
  region = "us-east-1"
}

module "static_website" {
  source                     = "../"
  static_website_bucket_name = "example.com"
  tag_name                   = "tag_name"
  domain_name                = "example.com"
}
