terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
    region                      = "us-east-1"
    shared_credentials_files    = ["~/.aws/credentials"]
    profile                     = "default"
}

provider "archive" {}

data "aws_iam_role" "main_role" {
    name = "LabRole"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_function" "lambda_function_test" {
  filename = "lambda_function_payload.zip"
  function_name = "lambda_function"
  role = data.aws_iam_role.main_role.arn
  handler = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.12"
}

resource "aws_lambda_invocation" "lambda_invocation_test"{
  function_name = aws_lambda_function.lambda_function_test.function_name
  input = jsonencode(var.lambda_input)
}
