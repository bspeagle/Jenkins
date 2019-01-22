output "lbsg_id" {
  value = "${aws_security_group.lbsg.id}"
}

output "ec2sg_id" {
  value = "${aws_security_group.ec2sg.id}"
}

output "ec2_instance_profile_name" {
  value = "${aws_iam_instance_profile.ec2_profile.name}"
}