resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.packer_build.id}"]
  key_name = "${var.key_name}"
  availability_zone = "eu-west-1b"
  subnet_id = "${aws_subnet.Oct9pub-snet.id}"
  tags = {
    Name = "Bastion"
    env = "dev"
    author = "Limitless29"

}
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.packer_ami.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.packer_build.id}"]
  availability_zone = "eu-west-1a"
  subnet_id = "${aws_subnet.Oct9prv-snet.id}"
  key_name = "${var.key_name}"
  tags = {
    Name = "WebServer"
    env = "dev"
    author = "Limitless29"

}
}

