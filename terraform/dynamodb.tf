resource "aws_dynamodb_table" "results" {
  name           = "${var.owner}-dynamodb-${var.project}"
  billing_mode   = "PAY_PER_REQUEST"  # You can change this to "PROVISIONED" if needed
  hash_key       = "result_id"  # Change "result_id" to your desired primary key
  attribute {
    name = "result_id"  # Adjust this if needed
    type = "S"  # This is for string type. Change if needed.
  }

  tags = {
    Name      = "${var.owner}-dynamodb-${var.project}"
    Terraform = "true"
  }
}
