# --------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------
variable "static_website_bucket_name" {
  description = "The name of the S3 bucket that will host the static website"
  type        = string
  default     = ""
}
variable "tag_name" {
  description = "The name of the tag that will be applied toall resources"
  type        = string
  default     = "Static Website Build"
}


variable "domain_name" {
  description = "The domain name that will be used for the CloudFront distribution"
  type        = string
  default     = ""
}
