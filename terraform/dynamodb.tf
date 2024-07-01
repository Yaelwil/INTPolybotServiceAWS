resource "aws_dynamodb_table" "results" {
  name           = "${var.owner}-dynamodb-${var.project}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "result_id"

  attribute {
    name = "result_id"
    type = "S"
  }

  tags = {
    Name      = "${var.owner}-dynamodb-${var.project}"
    Terraform = "true"
  }
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.results.name
}
