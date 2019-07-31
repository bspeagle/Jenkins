data "aws_availability_zones" "azs" {}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.app}-${var.env}-vpc"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.app}-${var.env}-igw"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_subnet" "vpc_subnets" {
  count = 2
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, var.subnet_segment_start + count.index)}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"

  tags = {
    Name = "${var.app}-${var.env}-subnet${count.index}"
    App = "${var.app}"
    Env = "${var.env}"
  }
}

resource "aws_default_network_acl" "acl" {
  default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"
  
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.app}-${var.env}-acl"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_default_route_table" "default_rt" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.app}-${var.env}-default-rt"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}