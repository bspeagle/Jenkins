output "jMaster-lb-zoneId" {
  value = "${aws_lb.jMaster-lb.zone_id}"
}

output "jMaster-lb-dns" {
  value = "${aws_lb.jMaster-lb.dns_name}"
}