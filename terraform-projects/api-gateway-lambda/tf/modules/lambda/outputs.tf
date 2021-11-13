output "invoke_arn" {
  value       = aws_lambda_function.lambda.invoke_arn
  description = "Invoke arn for lambda"
}
