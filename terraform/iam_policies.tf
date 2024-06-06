#######################
# Access to S3 bucket #
#######################
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-access-policy"
  description = "Policy for s3 access"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = [
          "arn:aws:s3:::${var.owner}-bucket-${var.project}",
          "arn:aws:s3:::${var.owner}-bucket-${var.project}/*"
        ],
        Condition = {
          IpAddress = {
            "aws:SourceIp" : "10.0.0.0/16"
          }
        }
      }
    ]
  })
}

#######################
# Access to DynamoDB #
#######################

resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "dynamodb-access-policy"
  description = "Policy for DynamoDB access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ],
        #TODO put the required variables
        Resource = "arn:aws:dynamodb:us-west-2:your-account-id:table/${aws_dynamodb_table.results.name}",
        Condition = {
          IpAddress = {
            "aws:SourceIp": var.main_vpc_cidr  # Replace with your VPN CIDR block
          }
        }
      }
    ]
  })
}

##############################
# Access to Yolov5 SQS queue #
##############################

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "sqs-access-policy"
  description = "Policy for SQS access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = "arn:aws:sqs:us-west-2:your-account-id:${var.sqs_queue_name}",
        Condition = {
          IpAddress = {
            "aws:SourceIp": var.main_vpc_cidr  # Replace with your VPN CIDR block
          }
        }
      }
    ]
  })
}

###############################
# Access to filters SQS queue #
###############################

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "sqs-access-policy"
  description = "Policy for SQS access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = "arn:aws:sqs:us-west-2:your-account-id:${var.sqs_queue_name}",
        Condition = {
          IpAddress = {
            "aws:SourceIp": var.main_vpc_cidr  # Replace with your VPN CIDR block
          }
        }
      }
    ]
  })
}

#############################
# Access to secrets manager #
#############################

resource "aws_iam_policy" "secretsmanager_access_policy" {
  name        = "secretsmanager-access-policy"
  description = "Policy for Secrets Manager access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = aws_secretsmanager_secret.example.arn
      }
    ]
  })
}