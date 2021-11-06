terraform {
  backend "s3" {
    bucket = "tf-state-production"
    key    = "terraform-projects/api-gateway-lambda/state"
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
  service_name = "api_gateway_lambda_example"
}

module "lambda" {
  source = "../../modules/lambda"
  name   = local.service_name
}

module "api_gateway" {
  source      = "../../modules/api_gateway"
  name        = local.service_name
  environment = local.environment
}
