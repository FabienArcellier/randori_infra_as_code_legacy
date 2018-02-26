# variables.tf
data "aws_vpc" "selected" {
  id = "vpc-42822d24"
}

data "aws_subnet" "selected" {
  id = "subnet-6ad6130c"
}

# ami.tf

data "aws_ami" "ubuntu" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20171208"]
  }
}

# security_groups.tf

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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

# ec2.tf

resource "aws_instance" "webserver_artemis" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name      = "FAR"
  subnet_id     = "${data.aws_subnet.selected.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags {
    owner = "FAR"
    Name  = "webserver_artemis"
  }

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
  ]
}

resource "aws_instance" "webserver_appolon" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name      = "FAR"
  subnet_id     = "${data.aws_subnet.selected.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags {
    owner = "FAR"
    Name  = "webserver_appolon"
  }

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
  ]
}

resource "aws_instance" "webserver_hermes" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name      = "FAR"
  subnet_id     = "${data.aws_subnet.selected.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags {
    owner = "FAR"
    Name  = "webserver_hermes"
  }

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
  ]
}

resource "aws_instance" "database_zeus" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name      = "FAR"
  subnet_id     = "${data.aws_subnet.selected.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags {
    owner = "FAR"
    Name  = "database_zeus"
  }

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
  ]
}

resource "aws_instance" "database_poseidon" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.nano"
  key_name      = "FAR"
  subnet_id     = "${data.aws_subnet.selected.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags {
    owner = "FAR"
    Name  = "database_poseidon"
  }

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
  ]
}

# output.tf
output "inventory" {
  value = <<_END
  [webserver]
  webserver_appolon ansible_host=${aws_instance.webserver_appolon.public_ip} ansible_user=ubuntu
  webserver_artemis ansible_host=${aws_instance.webserver_artemis.public_ip} ansible_user=ubuntu
  webserver_hermes ansible_host=${aws_instance.webserver_hermes.public_ip} ansible_user=ubuntu

  [database]
  database_poseidon ansible_host=${aws_instance.database_poseidon.public_ip} ansible_user=ubuntu
  database_zeus ansible_host=${aws_instance.database_zeus.public_ip} ansible_user=ubuntu
  _END
}