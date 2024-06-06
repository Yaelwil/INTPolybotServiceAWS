########################
# IAM Role for Polybot #
########################


resource "aws_iam_role" "polybot_role" {
  name = "polybot-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#######################
# IAM Role for YOLOv5 #
#######################

resource "aws_iam_role" "yolov5_role" {
  name = "yolov5-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}