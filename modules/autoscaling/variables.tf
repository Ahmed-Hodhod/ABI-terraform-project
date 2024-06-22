variable "desired_capacity" {
    description = "The number of Amazon EC2 instances that should be running in the group"
    default = 1
}
variable "max_size" {
    description = "The maximum size of the autoscaling group"
    default = 1
}
variable "min_size" {
    description = "The minimum size of the autoscaling group"
    default = 0
}
