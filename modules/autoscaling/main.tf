variable "launch_template_id" {

}
variable "launch_template_latest_version" {

}
variable "subnet_ids" {
  type = list(string)
}
resource "aws_autoscaling_group" "hodhod_wordpress" {
  name = "hodhod-terraform-ASG"
  vpc_zone_identifier = var.subnet_ids
  
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_latest_version
  }

  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size


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

