output "web_instance_ids" {
  description = "List of Web instance IDs"
  value       = aws_instance.web[*].id
}

output "web_private_ips" {
  description = "List of private IP addresses of Web instances"
  value       = aws_instance.web[*].private_ip
}

output "web_public_ips" {
  description = "List of public IP addresses of Web instances (if public)"
  value       = aws_instance.web[*].public_ip
}

output "redis_instance_id" {
  description = "Redis instance ID"
  value       = aws_instance.redis.id
}

output "redis_private_ip" {
  description = "Private IP address of Redis instance"
  value       = aws_instance.redis.private_ip
}

output "key_name" {
  description = "Key pair name used for instances"
  value       = aws_key_pair.deployer.key_name
}