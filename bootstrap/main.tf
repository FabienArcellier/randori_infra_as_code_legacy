data "aws_vpc" "selected" {
  id = "vpc-42822d24"
}

data "aws_subnet" "selected" {
  id = "subnet-6ad6130c"
}

resource "aws_security_group" "allow_ssh" {
  name        = "ssh"
  description = "Allow all ssh traffic from internet"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "http"
  description = "Allow all http and https traffic from internet"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "http"
  }
}

resource "aws_security_group" "aws_resource" {
  name        = "aws_resource"
  description = "instance from aws tenant"
  vpc_id      = "${data.aws_vpc.selected.id}"

  tags {
    Name = "aws_resource"
  }
}

resource "aws_security_group" "aws_allow_all" {
  name        = "aws_allow_all"
  description = "Allow all traffic from aws tenant"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = ["${aws_security_group.aws_resource.id}"]
  }

  tags {
    Name = "aws_allow_all"
  }
}