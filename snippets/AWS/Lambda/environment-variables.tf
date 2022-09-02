resource "aws_lambda_function" "test_lambda" {
  ...

  environment {
    variables = {
      DB_INSTANCE_ADDRESS = aws_db_instance.bl-db.address
    }
  }
}

/* Using Python
DB_INSTANCE_ADDRESS = os.getenv('DB_INSTANCE_ADDRESS')
*/
