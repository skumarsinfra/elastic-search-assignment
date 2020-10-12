#Create NAT Gateway
resource "aws_nat_gateway" "elastic-search-va" {
	allocation_id = "eipalloc-089a0e5401343ec82"
	subnet_id = aws_subnet.elastic-search-va-public-1e.id
	tags = {
		Name="elastic-search-va-nat"
    Env = "test"
	}
}
