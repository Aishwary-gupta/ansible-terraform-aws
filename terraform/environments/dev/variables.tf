variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name tag"
  type        = string
  default     = "ansible-terraform-automation"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for private database/cache subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key for EC2 instances"
  type        = string
  default     = "../../../keys/ansible_ed25519.pub"
}

variable "enable_nat_gateway" {
  description = "Whether to provision a NAT Gateway (set false for cost savings in dev)"
  type        = bool
  default     = false
}

variable "place_instances_in_public_subnets" {
  description = "Whether to place compute instances in public subnets with public IPs for dev cost savings"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_count" {
  description = "Number of web instances across AZs"
  type        = number
  default     = 2
}