terraform {
  backend "s3" {
    bucket = "tf-state-production"
    key    = "aws-accounts/state"
    region = "ap-southeast-2"
  }
}

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

module "bucket_tf_state" {
  source     = "../../modules/s3_bucket"
  name       = "tf-state-${local.environment}"
  acl        = "private"
  region     = "ap-southeast-2"
  versioning = true
}
