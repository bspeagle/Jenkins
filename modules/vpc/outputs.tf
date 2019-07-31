output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnets" {
  value = "${aws_subnet.vpc_subnets.*.id}"
}