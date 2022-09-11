data "aws_s3_object" "s3_archive" {
  bucket = "tf-state-production"
  key    = "lambda/build.zip"
  depends_on = [
    null_resource.build
  ]
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "Pokemon"
  s3_bucket        = "tf-state-production"
  s3_key           = "lambda/build.zip"
  source_code_hash = data.aws_s3_object.s3_archive.metadata.Sha
  runtime          = "python3.9"
  handler          = "handler.handler"
  role             = aws_iam_role.role.arn
  depends_on = [
    null_resource.build
  ]
}

resource "null_resource" "build" {
  triggers = {
    requirements = filesha256("./requirements.txt")
    source_code  = filesha256("./handler.py")
  }

  provisioner "local-exec" {
    command = "./upload.sh"
    interpreter = [
      "bash", "-c"
    ]
  }
}

resource "aws_iam_role" "role" {
  name = "lambda_role"

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
