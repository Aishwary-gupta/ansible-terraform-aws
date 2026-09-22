output "alb_dns_name" {
  description = "The public DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_target_group_arn" {
  description = "The Target Group ARN of the ALB"
  value       = module.alb.target_group_arn
}

output "web_instances" {
  description = "Web EC2 instances details"
  value = {
    ids         = module.compute.web_instance_ids
    private_ips = module.compute.web_private_ips
    public_ips  = module.compute.web_public_ips
  }
}

output "redis_instance" {
  description = "Redis EC2 instance details"
  value = {
    id         = module.compute.redis_instance_id
    private_ip = module.compute.redis_private_ip
  }
}

output "test_alb_command" {
  description = "Curl command to verify ALB"
  value       = "curl -I http://${module.alb.alb_dns_name}/healthz"
}