data "template_file" "user_data-jenkins" {
    template = "${file("../files/user_data-jenkins.tpl")}"

    vars {
      s3_bucket = "${var.s3_bucket}"
      env_file = "${var.env_file}"
      init_file = "${var.init_file}"
      plugin_script = "${var.plugin_script}"
      plugin_file = "${var.plugin_file}"
      jobs_file = "${var.jobs_file}"
    }
}

resource "aws_launch_configuration" "jMaster_lconfig" {
  image_id = "ami-b70554c8"
  instance_type = "t2.small"
  security_groups = ["${var.ec2sg_id}"]
  iam_instance_profile = "${var.ec2_instance_profile_name}"
  user_data = "${data.template_file.user_data-jenkins.rendered}"
  key_name = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "jMaster_asg" {
  max_size = 1
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 1
  launch_configuration = "${aws_launch_configuration.jMaster_lconfig.name}"
  vpc_zone_identifier = ["${var.sng1_id}","${var.sng2_id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "jMaster-lb-tg" {
  name = "${var.app}-${var.env}-master-lb-tg"
  port = 8080
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.app}-${var.env}-master-lb-tg"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_autoscaling_attachment" "jMaster-asg-tg-attach" {
  autoscaling_group_name = "${aws_autoscaling_group.jMaster_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.jMaster-lb-tg.arn}"
}

resource "aws_lb" "jMaster-lb" {
  name = "${var.app}-${var.env}-jMaster-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = ["${var.lbsg_id}"]
  subnets = ["${var.sng1_id}","${var.sng2_id}"]

  tags {
    Name = "${var.app}-${var.env}-jMaster-lb"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_lb_listener" "jMaster-forward" {
  load_balancer_arn = "${aws_lb.jMaster-lb.arn}"
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.jMaster-lb-tg.arn}"
    type = "forward"
  }
}