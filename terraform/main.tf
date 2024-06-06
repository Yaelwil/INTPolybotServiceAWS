#####################################################
# Associate the route table with the public subnets #
#####################################################
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-rt.id
}

########################################################
# Associate the target group with the Polybot instance #
########################################################
resource "aws_lb_target_group_attachment" "polybot_attachment" {
  count            = var.polybot_machines
  target_group_arn = aws_lb_target_group.polybot_tg.arn
  target_id        = element(aws_instance.polybot.*.id, count.index)
  port             = var.polybot_port
}

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

resource "aws_iam_role_policy_attachment" "polybot_sqs_attachment" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
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

resource "aws_iam_role_policy_attachment" "polybot_secretsmanager_attachment" {
  role       = aws_iam_role.polybot_role.name
  policy_arn = aws_iam_policy.secretsmanager_access_policy.arn
}

#############################
# Yolov5 access to DynamoDB #
#############################

resource "aws_iam_role_policy_attachment" "yolov5_dynamodb_attachment" {
  role       = aws_iam_role.yolov5_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

#################################
# Yolov5 access secrets manager #
#################################

resource "aws_iam_role_policy_attachment" "yolov5_secretsmanager_attachment" {
  role       = aws_iam_role.yolov5_role.name
  policy_arn = aws_iam_policy.secretsmanager_access_policy.arn
}

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
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}

resource "aws_iam_instance_profile" "polybot_instance_profile" {
  name = "polybot-instance-profile"
  role = aws_iam_role.polybot_role.name
}

resource "aws_iam_instance_profile" "yolov5_instance_profile" {
  name = "yolov5-instance-profile"
  role = aws_iam_role.yolov5_role.name
}