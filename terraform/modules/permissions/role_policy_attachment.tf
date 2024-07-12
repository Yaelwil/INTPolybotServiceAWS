resource "aws_iam_role_policy_attachment" "ec2_role_to_s3_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_role_to_dynamodb_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_role_to_sqs_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}


resource "aws_iam_role_policy_attachment" "ec2_role_to_sm_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secrets_manager_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_role_to_kms_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.kms_access_policy.arn
}


resource "aws_iam_role_policy_attachment" "ec2_role_to_route53_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.route53_policy.arn
}