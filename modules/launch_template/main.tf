variable "vpc_id" {

}
resource "aws_launch_template" "hodhod_template" {
  name                   = "hodhod-terraform-wordpress-template"
  image_id               = var.ami_id
  instance_type          = "t3.small"
  key_name               = "hodhod"
  vpc_security_group_ids = [aws_security_group.public_facing_sg.id]
  depends_on             = [aws_security_group.public_facing_sg]

  #user_data = filebase64("${path.module}/userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "hodhod-terraform-wordpress"
    }
  }
}


resource "aws_security_group" "public_facing_sg" {
  name        = "allow-from-internet"
  description = "Allow traffic from the internet. "
  vpc_id      = var.vpc_id

}

resource "aws_security_group_rule" "allow_ssh" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.public_facing_sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.public_facing_sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_https" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.public_facing_sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  from_port = 0
  to_port   = 65535

  protocol          = "tcp"
  security_group_id = aws_security_group.public_facing_sg.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}


output "launch_template_latest_version" {
  value = aws_launch_template.hodhod_template.latest_version
}
