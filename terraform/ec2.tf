## Creating EC2 Instance
resource "aws_instance" "elastic-search-ec2" {
  ami = "ami-0080e4c5bc078760e"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.elastic-search-va-public-1e.id}"
  key_name = "elastic-search"
  user_data = "${file("usrdata.sh")}"
  vpc_security_group_ids = ["${aws_security_group.elastic-search-sg.id}"]
  root_block_device{
       volume_size=30
   }
     tags = {
       Name = "esnode.cloud2ark.com"
   }
}
