# Terraform AWS Static Website

<hr/>

## Introduction

This is a Terraform module that deploys infastructure for a static website. Designed to be super simple for developing wanting to quickly deploy a website.

## What's Created

- S3 Bucket
- CloudFront Distribution
- Route 53 A record & AAAA Record
- ACM certificate

## Example

```bash

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
```

### CloudFront Information

CloudFront has been set up with the following:

```bash
price_class = PriceClass_All (All Locations)
viewer_protocol_policy = redirect-to-https
min_ttl = 0
default_ttl = 3600
max_ttl = 86400
```
