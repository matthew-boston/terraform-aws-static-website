<!-- ![Logo](https://camo.githubusercontent.com/1a4ed08978379480a9b1ca95d7f4cc8eb80b45ad47c056a7cfb5c597e9315ae5/68747470733a2f2f7777772e6461746f636d732d6173736574732e636f6d2f323838352f313632393934313234322d6c6f676f2d7465727261666f726d2d6d61696e2e737667) -->

<center>
<img src="https://camo.githubusercontent.com/1a4ed08978379480a9b1ca95d7f4cc8eb80b45ad47c056a7cfb5c597e9315ae5/68747470733a2f2f7777772e6461746f636d732d6173736574732e636f6d2f323838352f313632393934313234322d6c6f676f2d7465727261666f726d2d6d61696e2e737667" width="250">

<h1> Terraform AWS Static Website</h1>
</center>
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
