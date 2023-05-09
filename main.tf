# --------------------------------------------------------------------------
# Provider
# --------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-2"
  alias = "dns_zones"
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}

# --------------------------------------------------------------------------
# Backend
# --------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket     = "static-website-terraform-state"
    key        = "terraform.tfstate"
    region     = "eu-west-2"
  }
}