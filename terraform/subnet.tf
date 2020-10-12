#Create Public Subnet-a
resource "aws_subnet" "elastic-search-va-public-1e" {
  vpc_id = aws_vpc.elastic-search-va.id
  cidr_block = "10.1.0.0/26"
  availability_zone="us-east-1e"
   map_public_ip_on_launch=true
  tags = {
    Name = "public-io-1a"
    Env = "test"
  }
}
# Create PublicSubnet-b
resource "aws_subnet" "elastic-search-va-public-1b" {
  vpc_id = aws_vpc.elastic-search-va.id
  cidr_block = "10.1.0.64/26"
  availability_zone="us-east-1f"
   map_public_ip_on_launch=true
  tags = {
    Name = "public-io-1b"
    Env = "test"
  }
}

#Create Public private subnet-a
resource "aws_subnet" "elastic-search-va-private-1e" {
  vpc_id = aws_vpc.elastic-search-va.id
  cidr_block = "10.1.0.128/26"
  availability_zone="us-east-1e"
    tags = {
    Name = "private-io-1e"
    Env = "test"
  }
}
# Create private subnet-b
resource "aws_subnet" "elastic-search-va-private-1f" {
  vpc_id = aws_vpc.elastic-search-va.id
  cidr_block = "10.1.0.192/26"
  availability_zone="us-east-1f"
   map_public_ip_on_launch=true
  tags = {
    Name = "private-io-1f"
    Env = "test"
  }
}
