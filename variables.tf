# --------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------
variable "static_website_bucket_name" {
    description = "The name of the S3 bucket that will host the static website"
    type        = string
    default     = "mattboston-portfolio-website-1325567"
}

variable "tag_name" {
    description = "The name of the tag that will be applied toall resources"
    type        = string
    default     = "Matt Boston Portfolio Website"
}
 

 variable "domain_name" {
    description = "The domain name that will be used for the CloudFront distribution"
    type        = string
    default     = "mattboston.com"
   
 }



# --------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------
variable "access_key" {
    description = "The AWS access key"
    type        = string
    default = "AKIAXHWASH575CSMXLGA"
}

variable "secret_access_key" {
    description = "The AWS secret access key"
    type        = string
    default = "8jPFVX/+/IyBNgYPxYwln8hPo+S4ewYBiuEf8FhH"
}