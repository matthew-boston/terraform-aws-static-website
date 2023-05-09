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

variable "access_key" {
    description = "The AWS access key"
    type        = string
}

variable "secret_access_key" {
    description = "The AWS secret access key"
    type        = string
}