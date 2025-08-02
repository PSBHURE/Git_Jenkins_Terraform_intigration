resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = var.public_route_table
    gateway_id = aws_internet_gateway.INTERNATE_GATEWAY.id  #route table must be connected to the internet gateway 
  }

  tags = {
    Name = "public_route_table"
    Description = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {     #we will not connect this route table with internet gateway bcz if we provide 
                                                       #anyone from outside can sonnect with our private subnet but we do not want this 
                                                       #this private subnet should be access only via our our public subnet resource not
                                                       #by all over internate and if this private subnet want to communiate with outside 
                                                       #then we will use nat gateways.
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "private_route_table"
    Description = "private_route_table"    
  }
}

resource "aws_route_table_association" "public_subnet_associate_with_public_route_table" {     #This will connect pub subnet with pub route table
  subnet_id = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_associate_with_private_route_table" {  #This will connect pri subnet with pri route table
  subnet_id = aws_subnet.pri_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}