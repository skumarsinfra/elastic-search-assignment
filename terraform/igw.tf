#Create Internet Gateway
resource "aws_internet_gateway" "elastic-search-va" {
  vpc_id = aws_vpc.elastic-search-va.id

  tags = {
    Name = "elastic-search-igw-va"
    Env = "test"
  }
}
