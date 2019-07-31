data "template_file" "user_data_jenkins" {
  template = "${file("../files//user_data/user_data_jenkins.tpl")}"

  vars = {
    s3_bucket = "${var.s3_bucket}"
    env_file = "${var.env_file}"
    init_file = "${var.init_file}"
    plugin_script = "${var.plugin_script}"
    plugin_file = "${var.plugin_file}"
    jobs_file = "${var.jobs_file}"
  }
}

resource "aws_launch_configuration" "leader_lconfig" {
  image_id = "${var.ec2_ami}"
  instance_type = "${var.leader_instance_type}"
  security_groups = ["${var.ec2_sg_id}"]
  iam_instance_profile = "${var.ec2_instance_profile_name}"
  user_data = "${data.template_file.user_data_jenkins.rendered}"
  key_name = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "leader_asg" {
  max_size = 1
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 1
  launch_configuration = "${aws_launch_configuration.leader_lconfig.name}"
  vpc_zone_identifier = "${var.subnets}"

  tag {
    key = "Name"
    value = "${var.app}-${var.env}-leader-asg"
    propagate_at_launch = true
  }

  tag {
    key = "App"
    value = "${var.app}"
    propagate_at_launch = true
  }

  tag {
    key = "Env"
    value = "${var.env}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "leader_lb" {
  name = "${var.app}-${var.env}-leader-lb"
  load_balancer_type = "application"
  security_groups = ["${var.lb_sg_id}"]
  subnets = "${var.subnets}"

  tags = {
    Name = "${var.app}-${var.env}-leader-lb"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_lb_target_group" "leader_lb_http_tg" {
  name = "${var.app}-${var.env}-leader-lb-http--tg"
  port = 8080
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.app}-${var.env}-leader-http-lb-tg"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_autoscaling_attachment" "leader_asg_tg_attach" {
  autoscaling_group_name = "${aws_autoscaling_group.leader_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.leader_lb_http_tg.arn}"
}

resource "aws_lb_listener" "leader_http_forward" {
  load_balancer_arn = "${aws_lb.leader_lb.arn}"
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.leader_lb_http_tg.arn}"
    type = "forward"
  }
}