resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "${var.app}-VPC"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.app}-IGW"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "sn1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.app}-SNG-1"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_subnet" "sn2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.app}-SNG-2"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_network_acl" "acl" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.app}-ACL"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_route_table" "routeTable" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.app}-VPC-ROUTES"
    App  = "${var.app}"
    Env  = "${var.env}"
  }
}

resource "aws_route_table_association" "rta-A" {
  subnet_id      = "${aws_subnet.sn1.id}"
  route_table_id = "${aws_route_table.routeTable.id}"
}

resource "aws_route_table_association" "rta-B" {
  subnet_id      = "${aws_subnet.sn2.id}"
  route_table_id = "${aws_route_table.routeTable.id}"
}