output "VPC_ID" {
  value = aws_vpc.VPC.id
}

output "VPC_ARN" {
  value = aws_vpc.VPC.arn
}

output "pri_sub_id" {
  value = aws_subnet.pri_subnet.id
}

output "pub_sub_id" {
  value = aws_subnet.pub_subnet.id
}

output "Public_Server_IP"{
  value = aws_instance.Public_Server.public_ip
}

