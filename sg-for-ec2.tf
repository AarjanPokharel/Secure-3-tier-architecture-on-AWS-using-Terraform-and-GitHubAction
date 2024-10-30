
resource "aws_security_group" "ssh-access" {
  description = "Allow SSH on ec2"
  name = "${local.prefix}-sshAccess"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [var.vpc_cidrblock]
  }
  tags = local.common_tags
}