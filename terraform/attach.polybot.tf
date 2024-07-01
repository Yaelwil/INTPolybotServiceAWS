############################
# Attach Policies to Roles #
############################

########################
# Polybot access to S3 #
########################

resource "aws_iam_role_policy_attachment" "polybot_s3_attachment" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

#########################
# Polybot access to SQS #
#########################

resource "aws_iam_role_policy_attachment" "yolov5-sqs-queue" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.sqs_yolov5_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "filters-sqs-queue" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.sqs_filters_access_policy.arn
}

##############################
# Polybot access to DynamoDB #
##############################

resource "aws_iam_role_policy_attachment" "polybot_dynamodb_attachment" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

##################################
# Polybot access secrets manager #
##################################

# resource "aws_iam_role_policy_attachment" "polybot_secretsmanager_attachment" {
#   role       = aws_iam_role.polybot_role.name
#   policy_arn = aws_iam_policy.secretsmanager_access_policy.arn
# }