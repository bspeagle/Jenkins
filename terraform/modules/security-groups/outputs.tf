output "lb_sg_id" {
  description = "Id of load balancer security group"
  value       = aws_security_group.lb.id
}

output "ec2_sg_id" {
  description = "Id of ec2 security group"
  value       = aws_security_group.ec2.id
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.this.name
}