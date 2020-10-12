#Creating VPCs
resource "aws_vpc" "elastic-search-va" {
  cidr_block = "10.1.0.0/24"
  enable_dns_support=true
  enable_dns_hostnames=true
  tags = {
  Name = "elastic-search-va"
  Region = "us-east-1"
  Env = "test"
}
}
