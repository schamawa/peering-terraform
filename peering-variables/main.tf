resource "aws_vpc" "private_vpc" {
  cidr_block = var.vpc1_cidr
  tags = {
    name = "test"
}
}

resource "aws_vpc" "public_vpc" {
  cidr_block = var.vpc2_cidr
  tags = {
    name = "test"
}
}

##########Subnets######################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.public_vpc.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.zone
  map_public_ip_on_launch = "true"

  tags = {
    Name = "tf-example"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.private_vpc.id
  cidr_block = var.subnet1_cidr
  availability_zone = var.zone1
  map_public_ip_on_launch = "false"

  tags = {
    name = "test"
}
}

#####RT for igw####################################
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.public_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.public_vpc.id
  route {

    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }

  route {
    cidr_block = var.subnet1_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  }
  tags = {
    Name = "igw-route"
  }
}

resource "aws_route_table_association" "public-rta" {
  route_table_id = aws_route_table.public_route.id
  subnet_id = aws_subnet.public_subnet.id

}
###################RT for private subnet######################
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.private_vpc.id
  route {
    cidr_block = var.subnet2_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  }

  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table_association" "private-rta" {
  route_table_id = aws_route_table.private_route.id
  subnet_id = aws_subnet.private_subnet.id

}

########SG for Both#############################################

resource "aws_security_group" "public_sg" {
  name = "test"
  vpc_id = aws_vpc.public_vpc.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}


resource "aws_security_group" "private_sg" {
  name = "dev"
  vpc_id = aws_vpc.private_vpc.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}
