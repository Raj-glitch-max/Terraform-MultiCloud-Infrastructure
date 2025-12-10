resource "aws_dynamodb_table" "dynamodb_table" {
  name         = var.dynamodb_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST" # To enable serverless
  attribute {
    name = "LockID"
    type = "S"
  }
}