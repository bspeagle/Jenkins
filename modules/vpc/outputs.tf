output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "sng1_id" {
  value = "${aws_subnet.sn1.id}"
}

output "sng2_id" {
  value = "${aws_subnet.sn2.id}"
}