## ** Security Group Creation
resource "aws_security_group" "elastic-search-sg" {
  name = "elastic-search-sg"
  description = "Elastic Search Security Group"
  vpc_id = aws_vpc.elastic-search-va.id

#Allow ssh traffic from public network not a standard practice.
ingress {
 description = "SSH from public"
 from_port   = 22
 to_port     = 22
 protocol    = "tcp"
 cidr_blocks = ["223.226.23.58/32"]
}

# Allow ssh traffic from public network
ingress {
 description = "HTTPS for ELB"
 from_port   = 443
 to_port     = 443
 protocol    = "tcp"
 cidr_blocks = ["10.1.0.0/24"]
}



# Allow outbound traffic

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elastic-search-sg"
  }

}

resource "aws_security_group" "apache-elb-sg" {
  name = "apache-elb-sg"
  description = "Loadbalancer Security Group"
  vpc_id = aws_vpc.elastic-search-va.id


# Allow ssh traffic from public network
ingress {
 description = "HTTP from public"
 from_port   = 443
 to_port     = 443
 protocol    = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}


# Allow outbound traffic

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "apache-elb-sg"
  }

}
