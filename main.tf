provider "aws" {
  region = "us-east-1"
}
terraform {

  backend "s3" {
    bucket = "hodhod-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "hodhod-terraform-state-lock"
  }
}


module "vpc" {
  source = "./modules/vpc"
}
module "launch_template" {
  source = "./modules/launch_template"
  vpc_id = module.vpc.vpc_id

}

# module "database" {
#   source             = "./modules/database"
#   vpc_id             = module.vpc.vpc_id
#   database_subnet_id = module.vpc.private_subnet_id
#   vpc_cidr_block     = module.vpc.vpc_cidr_block
# }

module "autoscaling" {
  source             = "./modules/autoscaling"
  launch_template_id = module.launch_template.launch_template_id
  subnet_ids         = [module.vpc.public_subnet_id]
  # depends_on                     = [module.vpc, module.database]
  launch_template_latest_version = module.launch_template.launch_template_latest_version
}
