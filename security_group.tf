resource "aws_security_group" "CustomCG" {
  depends_on = [ aws_vpc.VPC ]
  name = "CustomCG"
  description = "Allow jenkins,Sonarque,SSH,HTML port"
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "CustomCG"
    Description = "CustomCG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_SSH" {
  security_group_id = aws_security_group.CustomCG.id
  cidr_ipv4 = var.public_route_table
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  tags = {
    name = "Allow_SSH"
    description = "Allow_SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_HTTP" {
  security_group_id = aws_security_group.CustomCG.id
  cidr_ipv4 = var.public_route_table
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  tags = {
    name = "Allow_HTTP"
    description = "Allow_HTTP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_Jenkins" {
  security_group_id = aws_security_group.CustomCG.id
  cidr_ipv4 = var.VPC_CIDR
  from_port = 8080
  to_port = 8080
  ip_protocol = "tcp"
    tags = {
    name = "Allow_Jenkins"
    description = "Allow_Jenkins"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_SonarCube" {
  security_group_id = aws_security_group.CustomCG.id
  cidr_ipv4 = var.VPC_CIDR
  from_port = 9000
  to_port = 9000
  ip_protocol = "tcp"
    tags = {
    name = "Allow_SonarCube"
    description = "Allow_SonarCube"
  }
}

# resource "aws_vpc_security_group_egress_rule" "Allow_Outgoint_Traffic" {
#   security_group_id = aws_security_group.CustomCG.id
#   cidr_ipv4 = var.public_route_table
#   ip_protocol = "-1"
#     tags = {
#     name = "Allow_Outgoint_Traffic"
#     description = "Allow_Outgoint_Traffic"
#   }
# }

resource "aws_vpc_security_group_egress_rule" "Allow_All_Outbound" {
  security_group_id = aws_security_group.CustomCG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "Allow_All_Outbound"
    Description = "Allow all outbound traffic"
  }
}
