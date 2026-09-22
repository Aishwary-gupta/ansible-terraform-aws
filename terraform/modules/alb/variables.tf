variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and Target Group will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "app_port" {
  description = "Backend port for the target group"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path for ALB health checks"
  type        = string
  default     = "/healthz"
}