variable "app" {}
variable "env" {}
variable "vpc_id" {}

resource "aws_security_group" "lbsg" {
  name        = "${var.app}-${var.env}-LB-SG"
  description = "SG for ${var.app} LB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.app}-${var.env}-LB-SG"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_security_group" "ec2sg" {
  name        = "${var.app}-${var.env}-EC2-SG"
  description = "SG for ${var.app} EC2 instances"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.app}-SG-EC2"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.app}-${var.env}_Access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-role-policy-attach" {
  role = "${aws_iam_role.ec2_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "s3-role-policy-attach" {
  role = "${aws_iam_role.ec2_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-role-policy-attach" {
  role = "${aws_iam_role.ec2_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr-role-policy-attach" {
  role = "${aws_iam_role.ec2_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.app}-${var.env}_Access"
  role = "${aws_iam_role.ec2_role.name}"
}

output "lbsg_id" {
  value = "${aws_security_group.lbsg.id}"
}

output "ec2sg_id" {
  value = "${aws_security_group.ec2sg.id}"
}

output "ec2_instance_profile_name" {
  value = "${aws_iam_instance_profile.ec2_profile.name}"
}