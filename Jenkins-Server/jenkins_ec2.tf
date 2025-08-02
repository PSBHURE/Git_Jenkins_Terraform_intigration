#fetching the default VPC
data "aws_vpc" "default"{
    default = "true"
}

#featching the default subnet
data "aws_subnets" "default_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name = "availability-zone"
    values = ["ap-south-1a"]
  }
}

resource "aws_key_pair" "Jenkins-Server-Key" {
  key_name = "terra_aws_key"
  public_key = file("terra_aws_key.pub")
}

resource "aws_security_group" "Jenkins-CG" {
  depends_on = [ data.aws_vpc.default ]
  name = "Jenkins-CG"
  description = "Allow jenkins port"
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = "Jenkins-CG"
    Description = "Jenkins-CG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_SSH" {
  security_group_id = aws_security_group.Jenkins-CG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  tags = {
    name = "Allow_SSH"
    description = "Allow_SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_HTTP" {
  security_group_id = aws_security_group.Jenkins-CG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  tags = {
    name = "Allow_HTTP"
    description = "Allow_HTTP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Allow_Jenkins" {
  security_group_id = aws_security_group.Jenkins-CG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 8080
  to_port = 8080
  ip_protocol = "tcp"
    tags = {
    name = "Allow_Jenkins"
    description = "Allow_Jenkins"
  }
}

resource "aws_vpc_security_group_egress_rule" "Allow_All_Outbound" {
  security_group_id = aws_security_group.Jenkins-CG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "Allow_All_Outbound"
    Description = "Allow all outbound traffic"
  }
}


resource "aws_instance" "Jenkins-Server" {
  depends_on = [ aws_security_group.Jenkins-CG ]
  ami = "ami-021a584b49225376d"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnets.default_subnet.ids[0]
  key_name = aws_key_pair.Jenkins-Server-Key.key_name
  vpc_security_group_ids = [aws_security_group.Jenkins-CG.id]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Server"
    Description = "Jenkins-Server"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}

output "Jenkins-Public-IP" {
  value = aws_instance.Jenkins-Server.public_ip
}

