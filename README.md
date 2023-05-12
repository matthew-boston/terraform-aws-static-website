# Terraform AWS Static Website

<hr/>

## Introduction

This is a Terraform module that deploys infastructure for a static website. Designed to besuper simple for developing wanting to quickly deploy a website.

## What's Created

- S3 Bucket
- CloudFront Distribution
- Route 53 A record
- ACM certificate

## Example

```
provider "aws" {
  region = "us-east-1"
}

module "static_website" {
  source                     = "../"
  static_website_bucket_name = "example.com"
  tag_name                   = "tag_name"
  domain_name                = "example.com"
}
```

### CloudFront Information

CloudFront has been set up with the following:

```
price_class = PriceClass_All (All Locations)
viewer_protocol_policy = redirect-to-https
min_ttl = 0
default_ttl = 3600
max_ttl = 86400
```
