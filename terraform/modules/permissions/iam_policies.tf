#######################
# Access to S3 bucket #
#######################
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.owner}-bucket-policy-${var.region}-${var.project}"
  description = "Policy for s3 access"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                var.bucket_arn,
                "${var.bucket_arn}/*"
            ]
        }
    ]
  })
}


#######################
# Access to DynamoDB #
#######################

resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "${var.owner}-dynamodb-policy-${var.region}-${var.project}"
  description = "Policy for DynamoDB access"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:UpdateItem",
                "dynamodb:GetRecords",
                "dynamodb:GetItem",
                "dynamodb:PutItem"
            ],
            "Resource": var.dynamodb_table_arn
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "dynamodb:ListTables",
            "Resource": "*"
        }
    ]
  })
}


##############################
# Access to Yolov5 SQS queue #
##############################

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "${var.owner}-sqs_policy-${var.region}-${var.project}"
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
          var.yolov5_sqs_queue_arn,
          var.filters_sqs_queue_arn
        ]
      }
    ]
  })
}

#############################
# Access to secrets manager #
#############################

resource "aws_iam_policy" "secrets_manager_access_policy" {
  name        = "${var.owner}-sm-policy-${var.region}-${var.project}"
  description = "Policy for Secrets Manager access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:ListSecrets"
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
  name        = "${var.owner}-kms-policy-${var.region}-${var.project}"
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
  name        = "${var.owner}-route53-policy${var.region}-${var.project}"
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
