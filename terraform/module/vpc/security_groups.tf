resource "aws_security_group" "packer_build" {
  name        = "packer-build"
  description = "Security Group for Packer Builds"
  #vpc_id      = "vpc-090377310c7acf853"
  vpc_id      = "${aws_vpc.Oct9vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "packer-build"
  }
}

resource "aws_vpc" "Oct9vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "${var.vpc_name}"
    }
}


resource "aws_subnet" "Oct9prv-snet" {
    vpc_id = "${aws_vpc.Oct9vpc.id}"
    cidr_block = "${var.prv_snet_cidr}"
    availability_zone = "eu-west-1a"

    tags =  {
        Name = "${var.prv_snet_name}"
    }
}

resource "aws_subnet" "Oct9pub-snet" {
    vpc_id = "${aws_vpc.Oct9vpc.id}"
    cidr_block = "${var.pub_snet_cidr}"
    availability_zone = "eu-west-1b"

    tags =  {
        Name = "${var.pub_snet_name}"
    }
}

resource "aws_internet_gateway" "Oct9igw" {
    vpc_id = "${aws_vpc.Oct9vpc.id}"
        tags =  {
        Name = "${var.IGW_name}"
    }
}


resource "aws_route_table" "Oct9pub-route" {
    vpc_id = "${aws_vpc.Oct9vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.Oct9igw.id}"
    }

    tags =  {
        Name = "${var.main_routing_table}"
    }
}

resource "aws_route_table_association" "Oct9pub-route-asso" {
    subnet_id = "${aws_subnet.Oct9pub-snet.id}"
    route_table_id = "${aws_route_table.Oct9pub-route.id}"
}
