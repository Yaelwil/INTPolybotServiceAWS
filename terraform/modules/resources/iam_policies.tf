#######################
# Access to S3 bucket #
#######################
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.owner}-bucket-policy-${var.project}"
  description = "Policy for s3 access"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.project_bucket.arn
        ],
        Condition = {
          IpAddress = {
            "aws:SourceIp" : var.main_vpc_cidr
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
  name        = "${var.owner}-dynamodb-policy-${var.project}"
  description = "Policy for DynamoDB access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
                "dynamodb:DeleteItem",
                "dynamodb:UpdateItem",
                "dynamodb:GetRecords",
                "dynamodb:GetItem",
                "dynamodb:PutItem"
        ],
        #TODO put the required variables
        Resource = aws_dynamodb_table.dynamodb-table.arn
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
  name        = "${var.owner}-sqs_policy-${var.project}"
  description = "Policy for SQS access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = [
          aws_sqs_queue.yolov5_sqs_queue.arn,
          aws_sqs_queue.filters_sqs_queue.arn
        ]
      }
    ]
  })
}

#############################
# Access to secrets manager #
#############################

resource "aws_iam_policy" "secrets_manager_access_policy" {
  name        = "${var.owner}-sm-policy-${var.project}"
  description = "Policy for Secrets Manager access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "*"
      }
    ]
  })
}

####################################
# Access to key management service #
####################################

resource "aws_iam_policy" "kms_access_policy" {
  name        = "${var.owner}-kms-policy-${var.project}"
  description = "Policy for KMS access"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "kms:Decrypt"
        ],
        Resource = "*"
      }
    ]
  })
}

######################
# Access to Route 53 #
######################

resource "aws_iam_policy" "route53_policy" {
  name        = "route53AccessPolicy"
  description = "Policy to allow creating and managing Route 53 subdomains"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "route53:ChangeResourceRecordSets",
          "route53:CreateHostedZone",
          "route53:GetHostedZone",
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
        ]
        Resource = "*"
      }
    ]
  })
}
