module "static_website" {
  source = "./module"

  static_website_bucket_name = var.static_website_bucket_name
  tag_name                   = var.tag_name
  domain_name                = var.domain_name
  access_key                 = var.access_key
  secret_access_key          = var.secret_access_key

}