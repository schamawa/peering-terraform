resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.public_vpc.id
  vpc_id        = aws_vpc.private_vpc.id
  auto_accept   = true
  tags = {
    Name = "VPC Peering between Public and Private"
  }
}
