variable "database_subnet_id" {

}

variable "vpc_id" {

}

variable "vpc_cidr_block" {

}
# create ec2 instance with mysql installed  
resource "aws_instance" "database" {
  ami             = var.database_ami
  instance_type   = var.database_type
  security_groups = [aws_security_group.database_sg.id]
  depends_on      = [aws_security_group.database_sg]
  subnet_id       = var.database_subnet_id
  key_name        = var.key_name

  tags = {
    Name = "hodhod-database"
  }
}

# only allow traffic from within the vpc 
resource "aws_security_group" "database_sg" {
  name        = "allow-from-within-vpc"
  description = "Allow traffic from within the vpc. "
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
}