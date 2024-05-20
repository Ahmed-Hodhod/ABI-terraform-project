variable "launch_template_id" {

}
variable "launch_template_latest_version" {

}
variable "allow_all_sg" {
  
}

variable "vpc_id" {

}

variable "subnet_ids" {
  type = list(string)
}
resource "aws_autoscaling_group" "hodhod_wordpress" {
  name                = "hodhod-terraform-ASG"
  vpc_zone_identifier = [var.subnet_ids[0]]

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_latest_version
  }

  min_size          = var.min_size
  desired_capacity  = var.desired_capacity
  max_size          = var.max_size
  target_group_arns = [aws_lb_target_group.hodhod_target_group.arn]



  tag {
    key                 = "Name"
    value               = "hodhod-terraform-asg"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "hodhod-terraform-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.hodhod_wordpress.name
}


resource "aws_lb" "hodhod_terraform_alb" {
  name               = "hodhod-terraform-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups = [var.allow_all_sg ]
}

resource "aws_lb_target_group" "hodhod_target_group" {
  name     = "hodhod-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "hodhod_alb_listener" {
  load_balancer_arn = aws_lb.hodhod_terraform_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hodhod_target_group.arn
  }
}
