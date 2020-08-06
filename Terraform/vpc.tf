resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "alex-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "alex-internet-gateway"
  }
}

resource "aws_route_table" "external_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "alex-external-route-table"
  }
}

resource "aws_route" "external_route_0" {
  route_table_id            = aws_route_table.external_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gateway.id
}

resource "aws_subnet" "subnet_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "alex-subnet-0"
  }
}

resource "aws_route_table_association" "subnet_0" {
  subnet_id      = aws_subnet.subnet_0.id
  route_table_id = aws_route_table.external_route_table.id
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.128.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "alex-subnet-1"
  }
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.external_route_table.id
}

data "aws_availability_zones" "available" {
  state = "available"
}
