provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      environment = local.environment
      respository = local.service_name
    }
  }
}

locals {
  environment  = "production"
  service_name = "aws_accounts_${local.environment}"
}

module "iam" {
  source = "../../modules/iam"
  name   = local.service_name
}
