variable "database_subnet_id" {}

variable "vpc_id" {}

variable "vpc_cidr_block" {}

# create ec2 instance with mysql installed  
resource "aws_instance" "database" {
  ami           = var.database_ami
  instance_type = var.database_type
  depends_on = [aws_security_group.database_sg]
  key_name = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.database_eni.id
    device_index         = 0
  }
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

resource "aws_network_interface" "database_eni" {
  subnet_id       = var.database_subnet_id
  private_ips     = ["10.0.141.88"]
  security_groups = [aws_security_group.database_sg.id]

  tags = {
    Name = "hodhod-database-eni"
  }
}
