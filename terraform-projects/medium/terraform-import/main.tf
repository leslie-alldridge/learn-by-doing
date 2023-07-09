terraform {
  backend "s3" {
    bucket = "tf-state-production"
    key    = "terraform-projects/medium/state"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      respository = "medium-terraform-import"
    }
  }
}

resource "aws_iam_role" "my_role" {
  assume_role_policy   = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  managed_policy_arns  = ["arn:aws:iam::xxx:policy/service-role/AWSLambdaBasicExecutionRole-eb83140e-df5d-41f5-a28a-9769ad40dde5"]
  max_session_duration = 3600
  name                 = "my-role"
}
