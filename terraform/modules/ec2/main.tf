resource "aws_launch_configuration" "this" {
  name_prefix   = var.name_prefix
  image_id      = data.aws_ami.this.id
  instance_type = var.instance_type

  iam_instance_profile = var.ec2_instance_profile_name
  security_groups = [
    var.ec2_sg_id
  ]

  # user_data = data.template_file.user_data_jenkins.rendered
  key_name = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name = var.name_prefix

  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier  = var.subnets

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  dynamic "tag" {
    for_each = data.aws_default_tags.this.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = var.name_prefix
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "this" {
  name               = "${var.name_prefix}-lb"
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets

  security_groups = [
    var.lb_sg_id
  ]

  tags = {
    "Name" = "${var.name_prefix}-lb"
  }
}

resource "aws_lb_target_group" "this" {
  count = length([
    for object in var.load_balancer_config : object
  ])

  name = "${var.name_prefix}-${lower(
    [
      for object in var.load_balancer_config : object.protocol
    ][count.index]
  )}"

  vpc_id = var.vpc_id

  protocol = [
    for object in var.load_balancer_config : object.protocol
  ][count.index]

  port = [
    for object in var.load_balancer_config : [
      for config in object.config : config.port
      if config.type == "target_group"
    ][0]
  ][count.index]

  tags = {
    "Name" = "${var.name_prefix}-${lower(
      [
        for object in var.load_balancer_config : object.protocol
      ][count.index]
    )}"
  }
}

resource "aws_autoscaling_attachment" "this" {
  count = length([
    for object in var.load_balancer_config : object
  ])

  autoscaling_group_name = aws_autoscaling_group.this.id
  alb_target_group_arn   = aws_lb_target_group.this[count.index].arn
}

resource "aws_lb_listener" "this" {
  count = length([
    for object in var.load_balancer_config : object
  ])

  load_balancer_arn = aws_lb.this.arn

  protocol = [
    for object in var.load_balancer_config : object.protocol
  ][count.index]

  port = [
    for object in var.load_balancer_config : [
      for config in object.config : config.port
      if config.type == "listener"
    ][0]
  ][count.index]

  default_action {
    target_group_arn = aws_lb_target_group.this[count.index].arn
    type             = "forward"
  }

  tags = {
    "Name" = "${var.name_prefix}-${lower(
      [
        for object in var.load_balancer_config : object.protocol
      ][count.index]
    )}"
  }
}