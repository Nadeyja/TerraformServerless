terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform.state.backend.bucket"
    dynamodb_table = "terraform-state-backend-dynamodb"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}