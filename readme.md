## Provisioning the infrastructure using Terraform 

## Video Demo 

Use this [link](https://youtu.be/kYJAe-lQEQ8) to watch the [Video Demo](https://youtu.be/kYJAe-lQEQ8) of this project. 

## Project Requirements 
- create a vpc with 2 public subnets and a private subnet 
- create a launch template that contains your image of wordpress
- create an autoscaling group that has 2 machines of type t3.small and a simple scaling policy that adds
more machines if cpu reaches 50%
- database instance with mysql 8 installed on it
- use s3 as backend for your terraform state
- try to separate the functions of your terraform into abstract modules


## Prerequisites to run the project 
- use the command `aws configure` to provide the access keys to awscli
- use your own bucket for the state in the file `main.tf` in the root directory 
- assign the variable values according to your needs especially the ami and other per-region parameters


## Ryn the project 
```
terraform validate 
terraform plan 
terraform apply 
```

## Destroy the resources 
```
terraform destroy 
```

## List the provisioned resources 
```
terraform state list 
```
