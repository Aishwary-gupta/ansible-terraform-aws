variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "web_subnet_ids" {
  description = "Subnet IDs for multi-AZ Web instances"
  type        = list(string)
}

variable "redis_subnet_id" {
  description = "Subnet ID for Redis cache instance"
  type        = string
}

variable "web_security_group_id" {
  description = "Security group ID for Web instances"
  type        = string
}

variable "redis_security_group_id" {
  description = "Security group ID for Redis instance"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN for web instances"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_count" {
  description = "Number of web EC2 instances to provision across AZs"
  type        = number
  default     = 2
}

variable "associate_public_ip_address_web" {
  description = "Whether to assign a public IP to web instances"
  type        = bool
  default     = false
}