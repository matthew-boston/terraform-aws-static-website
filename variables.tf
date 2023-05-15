# --------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------
variable "static_website_bucket_name" {
  description = "The name of the S3 bucket that will host the static website"
  type        = string
}
variable "tag_name" {
  description = "The name of the tag that will be applied toall resources"
  type        = string
}

variable "domain_name" {
  description = "The domain name that will be used for the CloudFront distribution"
  type        = string

}

variable "domain_prefix" {
  description = "The domain prefix that will be used placed infront of the domain"
  type        = string
  default     = "www"
}


variable "region" {
  description = "When all of your resources will be generated"
  type        = string
  default     = "us-east-1"
}


variable "restriction_type" {
  description = "The type of restriction that will be applied to the CloudFront distribution"
  type        = string
  default     = "none"
}
variable "restriction_locations" {
  description = "The locations that will be restricted from accessing the CloudFront distribution"
  type        = list(string)
  default     = []
}


variable "price_class" {
  description = "The price class that will be used for the CloudFront distribution (PriceClass_All, PriceClass_200, PriceClass_100)"
  type        = string
  default     = "PriceClass_All"
}
