data "aws_route53_zone" "cloud_zone" {
  name = "${var.cloud_zone}."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.cloud_zone.zone_id}"
  name = "${var.record_name}"
  type = "A"
  
  alias {
    name = "${var.leader_lb_dns}"
    zone_id = "${var.leader_lb_zone}"
    evaluate_target_health = true
  }
}