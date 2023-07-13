terraform {
  backend "local" {}
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      respository = "medium-terraform-import"
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_hello_w2orld_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  function_name    = "hello-world-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./handler.py"
  output_path = "./handler.zip"
}

check "latest_lambda_runtime" {
  assert {
    condition     = contains(["python3.9", "python3.10"], aws_lambda_function.test_lambda.runtime)
    error_message = "Please upgrade from ${aws_lambda_function.test_lambda.runtime} to python3.9 or python3.10"
  }
}

check "name_quality_check" {
  assert {
    condition     = !strcontains(aws_lambda_function.test_lambda.function_name, "hello-world")
    error_message = "Hello world functions are not allowed in production. Your function is named: ${aws_lambda_function.test_lambda.function_name}"
  }
}

check "cost_centre_tags_on_all_resources" {
  assert {
    condition = (
      can(aws_lambda_function.test_lambda.tags_all["product-name"]) &&
      can(aws_lambda_function.test_lambda.tags_all["cost-centre"])
    )
    error_message = "Please add tags for cost allocation. Your tags must include 'cost-centre' and 'product-name'"
  }
}
