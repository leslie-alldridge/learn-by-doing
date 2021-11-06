terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

// The api gateway itself
resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.name
  description = var.name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

// Create a path named "resource"
resource "aws_api_gateway_resource" "api_gateway" {
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "resource"
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
}

// A get method is added to "resource" path
// "Method Request" box
resource "aws_api_gateway_method" "api_gateway" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.api_gateway.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
}

// We integrate with mock (could be S3, Lambda, etc)
// "Integration Request" box
resource "aws_api_gateway_integration" "api_gateway" {
  http_method = aws_api_gateway_method.api_gateway.http_method
  resource_id = aws_api_gateway_resource.api_gateway.id
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  type        = "MOCK"
  request_templates = {
    "application/json" = jsonencode(
      {
        statusCode = 200
      }
    )
  }
}

// Our integration response
// "Integration Response" box
resource "aws_api_gateway_integration_response" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway.id
  http_method = aws_api_gateway_method.api_gateway.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
}

// We respond with a 200 response code (final response)
// "Method Response" box
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway.id
  http_method = aws_api_gateway_method.api_gateway.http_method
  status_code = 200
}

// The api is deployed when api_gateway_rest_api is edited
resource "aws_api_gateway_deployment" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

// Deployment stage name
resource "aws_api_gateway_stage" "api_gateway" {
  deployment_id = aws_api_gateway_deployment.api_gateway.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = var.name
}

// Policy and role for cloudwatch logs
data "aws_iam_role" "cloudwatch" {
  name = "cloudwatch_aws_accounts_${var.environment}"
}

resource "aws_api_gateway_account" "api_gateway" {
  cloudwatch_role_arn = data.aws_iam_role.cloudwatch.arn
}
