############################
# Attach Policies to Roles #
############################

########################
# filters access to S3 #
########################

resource "aws_iam_role_policy_attachment" "filters_s3_attachment" {
  role       = aws_iam_role.filters_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

##############################
# filters access to SQS queue #
##############################

resource "aws_iam_role_policy_attachment" "filters_sqs_attachment" {
  role       = aws_iam_role.filters_role.name
  policy_arn = aws_iam_policy.sqs_filters_access_policy.arn
}