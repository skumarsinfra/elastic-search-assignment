## Creating Elastic Loadbalancer and attaching ssl Certificate
resource "aws_elb" "apache" {
	name= "va-demo-esnode-elb"
	listener{
		instance_port=443
		instance_protocol= "https"
		lb_port= 443
		lb_protocol= "https"
		ssl_certificate_id = "arn:aws:acm:us-east-1:335846826657:certificate/a034c33b-b845-45db-bbf5-8f0cb8f0f2ba"
	}
  health_check {
		healthy_threshold= 3
		unhealthy_threshold = 2
		timeout= 10
		target= "https:443/"
		interval= 30
	}
  subnets=[
		"${aws_subnet.elastic-search-va-public-1e.id}",
		"${aws_subnet.elastic-search-va-public-1f.id}"
	]
  security_groups=[
		"${aws_security_group.apache-elb-sg.id}"
	]
  }

resource "aws_elb_attachment" "elbattach" {
  elb      = aws_elb.apache.id
  instance = aws_instance.elastic-search-ec2.id
}
