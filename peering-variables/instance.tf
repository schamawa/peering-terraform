resource "aws_instance" "public_ec2" {
   ami = var.image_id
   subnet_id = aws_subnet.public_subnet.id
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.public_sg.id]




   tags = {
    name = "prod"
}
}

resource "aws_instance" "private_ec2" {
   ami = var.image_id
   subnet_id = aws_subnet.private_subnet.id
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.private_sg.id]




   tags = {
    name = "test"
}
}
