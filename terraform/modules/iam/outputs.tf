output "instance_profile_name" {
  description = "The name of the EC2 IAM Instance Profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "role_arn" {
  description = "The ARN of the EC2 IAM Role"
  value       = aws_iam_role.ec2_role.arn
}