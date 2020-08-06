resource "aws_security_group" "alexs_sg_bc" {
  name        = "alexs-sg-bc"
  description = "need to log in with password"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name          = "Alexs Security Group"
    creation_date = "${timestamp()}"
    creator       = "${var.creator}"
    org           = "${var.org}"
    source        = "terraform"
  }
  lifecycle {
      ignore_changes = [
        tags["creation_date"]
      ]
    }
}

output "alexs_sg_bc_id"{
  value = aws_security_group.alexs_sg_bc.id
}

resource "aws_security_group_rule" "alexs_sg_bc_self" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  source_security_group_id = aws_security_group.alexs_sg_bc.id
  security_group_id = aws_security_group.alexs_sg_bc.id
}

resource "aws_security_group_rule" "alexs_sg_bc_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "69.27.5.110/32"
  ]
  security_group_id = aws_security_group.alexs_sg_bc.id
}

resource "aws_security_group_rule" "alexs_sg_bc_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.alexs_sg_bc.id
}

resource "aws_security_group_rule" "alexs_sg_bc_out" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  ipv6_cidr_blocks =[
      "::/0"
  ]
  security_group_id = aws_security_group.alexs_sg_bc.id
}
