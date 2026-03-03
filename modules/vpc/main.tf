resource "aws_vpc" "alex" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "alex.com"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.alex.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "alex.com.pub001"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.alex.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "alex.com.priv001"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.alex.id

  tags = {
    Name = "alex.com.g/w-001"
  }
}

resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "alex.com.nat_g/w_001"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.alex.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "alex-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.alex.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "alex-private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
