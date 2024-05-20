output "launch_template_id" {
  value = aws_launch_template.hodhod_template.id
}

output "allow_all_sg" {
  value = aws_security_group.public_facing_sg.id
}