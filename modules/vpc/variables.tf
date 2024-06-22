variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.0.0/20"
}

variable "public_subnet_cidr2" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.64.0/20"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.128.0/20"
}
variable "availability_zone" {
  description = "The availability zone for the VPC"
  default     = "us-east-1a"
}

variable "availability_zone2" {
  description = "The second availability zone for the VPC"
  default     = "us-east-1b"
}
