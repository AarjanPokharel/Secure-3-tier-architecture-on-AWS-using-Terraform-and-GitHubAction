resource "aws_instance" "public_ec2" {
  ami = data.aws_ami.amazon-linux_ami.id
  instance_type = var.instance_type
  availability_zone = "${var.region}a"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [ aws_security_group.ssh-access.id, ]
  key_name = var.sshkey
  
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-public-ec2"}))
}

resource "aws_instance" "private_ec2" {
    ami = data.aws_ami.amazon-linux_ami.id
    instance_type = var.instance_type
    availability_zone = "${var.instance_type}a"
    subnet_id = aws_subnet.private
    vpc_security_group_ids = [ aws_security_group.ssh-access.id, ]
    key_name = var.sshkey

    tags = merge(local.common_tags,tomap({"name" = "${local.prefix}-private-ec2"}))

}