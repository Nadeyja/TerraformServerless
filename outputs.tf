output "return" {
  value = jsondecode(aws_lambda_invocation.lambda_invocation_test.result)
}