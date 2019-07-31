resource "aws_security_group" "lb" {
  name = "${var.app}-${var.env}-lb-sg"
  description = "sg for ${var.app}-${var.env} lb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-${var.env}-lb-sg"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_security_group" "ec2" {
  name = "${var.app}-${var.env}-ec2-sg"
  description = "sg for ${var.app}-${var.env} ec2 instances"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-ec2-sg"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.app}-${var.env}-ec2-role"

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

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.app}-${var.env}-ec2-profile"
  role = "${aws_iam_role.ec2_role.name}"
}