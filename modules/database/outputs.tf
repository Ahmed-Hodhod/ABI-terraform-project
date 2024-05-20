output "database_instance_endpoint" {
  value = aws_instance.database.private_ip
}
