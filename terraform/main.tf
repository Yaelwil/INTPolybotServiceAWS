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

resource "aws_iam_instance_profile" "polybot_instance_profile" {
  name = "polybot-instance-profile"
  role = aws_iam_role.polybot_role.name
}

resource "aws_iam_instance_profile" "yolov5_instance_profile" {
  name = "yolov5-instance-profile"
  role = aws_iam_role.yolov5_role.name
}