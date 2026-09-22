output "alb_security_group_id" {
  description = "Security Group ID of the ALB"
  value       = aws_security_group.alb.id
}

output "web_security_group_id" {
  description = "Security Group ID of the Web instances"
  value       = aws_security_group.web.id
}

output "redis_security_group_id" {
  description = "Security Group ID of the Redis instance"
  value       = aws_security_group.redis.id
}