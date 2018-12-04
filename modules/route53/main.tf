variable "app" {}
variable "env" {}
variable "zone_id" {}
variable "record_name" {}
variable "jMaster-lb-zoneId" {}
variable "jMaster-lb-dns" {}

resource "aws_route53_record" "www" {
  zone_id = "${var.zone_id}"
  name = "${var.record_name}"
  type = "A"
  
  alias {
    name = "${var.jMaster-lb-dns}"
    zone_id = "${var.jMaster-lb-zoneId}"
    evaluate_target_health = true
  }
}