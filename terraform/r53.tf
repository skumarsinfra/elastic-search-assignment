# Adding ELB to R53
data "aws_route53_zone" "Domain" {
		name="cloud2ark.com."
}
resource "aws_route53_record" "apache_elb" {
	zone_id = "${data.aws_route53_zone.Domain.zone_id}"
	name= "demo"
	type= "A"
	alias {
		name= "${aws_elb.apache.dns_name}"
		zone_id= "${aws_elb.apache.zone_id}"
		evaluate_target_health = false
	}
}
