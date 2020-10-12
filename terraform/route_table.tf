#Tag Main Route Table and private subnet will be associated with this route table.
resource "aws_default_route_table" "private-io-rtb" {
	default_route_table_id = "${aws_vpc.elastic-search-va.default_route_table_id}"
	  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.elastic-search-va.id}"
  }
  tags = {
		Name = "elastic-search-private-io-rtb"
		}
  }
## -- Associate Private Subnets to private-io-rtb --

resource "aws_route_table_association" "private-io-1e"{
    subnet_id = aws_subnet.elastic-search-va-private-1e.id
    route_table_id = aws_default_route_table.private-io-rtb.id
  }

  resource "aws_route_table_association" "private-io-1f"{
      subnet_id = aws_subnet.elastic-search-va-private-1f.id
      route_table_id = aws_default_route_table.private-io-rtb.id
    }
## ** Create Public Route table ***
resource "aws_route_table" "elastic-search-private-io-rtb" {
  vpc_id = aws_vpc.elastic-search-va.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elastic-search-va.id
  }
  tags = {
    Name = "elastic-search-private-io-rtb"
  }
  }
  #Associating public subnet
  resource "aws_route_table_association" "public-io-1e"{
    subnet_id = aws_subnet.elastic-search-va-public-1e.id
    route_table_id = aws_route_table.elastic-search-private-io-rtb.id
  }
  resource "aws_route_table_association" "public-io-1f"{
    subnet_id = aws_subnet.elastic-search-va-public-1b.id
    route_table_id = aws_route_table.elastic-search-private-io-rtb.id
  }
