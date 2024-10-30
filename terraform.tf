provider "aws" {
    region = var.region 
}

# ALL THE NETWORK RESOURCES ARE FOUND IN THE UPCOMING CODE SECTION

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidrblock
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-vpc"}))
}

resource "aws_subnet" "public" {
  cidr_block = var.subnet_cidr[0]
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-publicSubnet"}))
}

resource "aws_subnet" "private_a" {
  cidr_block = var.subnet_cidr[1]
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-privateSubnetA"}))
}

resource "aws_subnet" "private_b" {
  cidr_block = var.subnet_cidr[2]
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.region}b"

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-privateSubnetB"}))
}

resource "aws_internet_gateway" "igw_main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-IGW"}))
  
}

resource "aws_eip" "eip_for_ngw" {
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-EIP"}))
}

resource "aws_nat_gateway" "ngw_main" {
  allocation_id = aws_eip.eip_for_ngw.id
  subnet_id = aws_subnet.public.id
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-NGW"}))
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-publicRoute"}))

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags,tomap({"Name" = "${local.prefix}-privateRoute"}))

}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-a_association" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-b_association" {
  subnet_id = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.igw_main.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_to_nat" {
  route_table_id = aws_route_table.private.id
  nat_gateway_id = aws_nat_gateway.ngw_main.id
  destination_cidr_block = "0.0.0.0/0"
}







