# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = true
}

# Security Groups Module
module "security_groups" {
  source = "../../modules/security_groups"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  allowed_ssh_cidrs = ["0.0.0.0/0"]
}

# IAM Module
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

# ALB Module
module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
  health_check_path = "/healthz"
}

# Compute Module
module "compute" {
  source = "../../modules/compute"

  project_name                    = var.project_name
  environment                     = var.environment
  web_subnet_ids                  = var.place_instances_in_public_subnets ? module.vpc.public_subnet_ids : module.vpc.private_subnet_ids
  redis_subnet_id                 = var.place_instances_in_public_subnets ? module.vpc.public_subnet_ids[0] : module.vpc.database_subnet_ids[0]
  web_security_group_id           = module.security_groups.web_security_group_id
  redis_security_group_id         = module.security_groups.redis_security_group_id
  instance_profile_name           = module.iam.instance_profile_name
  target_group_arn                = module.alb.target_group_arn
  ssh_public_key_path             = var.ssh_public_key_path
  instance_type                   = var.instance_type
  web_instance_count              = var.web_instance_count
  associate_public_ip_address_web = var.place_instances_in_public_subnets
}