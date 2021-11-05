provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      Environment = "production"
      respository = local.service_name
    }
  }
}

locals {
  service_name = "api_gateway_lambda_example"
}

module "lambda" {
  source = "../../modules/lambda"
  name   = local.service_name
}
