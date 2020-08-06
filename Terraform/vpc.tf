resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "alex-vpc"
  }
}

resource "aws_subnet" "subnet_0" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "alex-subnet-0"
  }
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

data "aws_availability_zones" "available" {
  state = "available"
}

output "aws_subnet_1-id" {
  value = aws_subnet.subnet_0.id
}
