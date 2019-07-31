output "lb_sg_id" {
  value = "${aws_security_group.lb.id}"
}

output "ec2_sg_id" {
  value = "${aws_security_group.ec2.id}"
}

output "ec2_instance_profile_name" {
  value = "${aws_iam_instance_profile.ec2_profile.name}"
}