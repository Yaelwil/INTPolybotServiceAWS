############################
# Attach Policies to Roles #
############################

#############################
# Yolov5 access to DynamoDB #
#############################

resource "aws_iam_role_policy_attachment" "yolov5_dynamodb_attachment" {
  role       = aws_iam_role.yolov5_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

# #################################
# # Yolov5 access secrets manager #
# #################################
#
# resource "aws_iam_role_policy_attachment" "yolov5_secretsmanager_attachment" {
#   role       = aws_iam_role.yolov5_role.name
#   policy_arn = aws_iam_policy.secretsmanager_access_policy.arn
# }

#######################
# Yolov5 access to S3 #
#######################

resource "aws_iam_role_policy_attachment" "yolov5_s3_attachment" {
  role       = aws_iam_role.yolov5_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

##############################
# Yolov5 access to SQS queue #
##############################

resource "aws_iam_role_policy_attachment" "yolov5_sqs_attachment" {
  role       = aws_iam_role.yolov5_role.name
  policy_arn = aws_iam_policy.sqs_yolov5_access_policy.arn
}