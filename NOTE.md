# elastic-search-assignment
Requirement  understood.
-	We need to build an ec2 instance which is having elasticsearch installed in it and should be able to access elastic search securely with username and password authentication.
Solution: 
-	In this I have taken ec2 t2.micro Amazon linux instance, deployed in public network( this can be in private network also but for ssh convenient I deployed it in public network).
-	Installed apache2 and elastic search packages.
-	Configured proxypass in web server which will act as a proxy between elastic search and public network by through ssl port.
-	Configured ELB and attached SSL Certificate to Load balancer, since I own cloud2ark.com domain I have installed valid certificate in the load balancer.
AWS Services Used.
-	VPC (Cidr Block 10.1.0.0/14)
-	Subnets (private and public for future expansion)
-	Security Groups 
o	elastic-search-sg  
	exposed port 443 to ELB
	exposed port 22 to [My IP for ssh access]
o	apache-elb-sg
	exposed port 443 to public network.
-	Internet Gateway attached to public network.
-	NAT Gateway attached to public network to route the traffic from private subnets.
-	Elastic Load Balancer (EC2 instance attached)
-	Route53 for public access. 
o	Added A record for ELB for public access. https://demo.cloud2ark.com
DevOps Tool:
	Used Terraform tool for provisioning the infrastructure. 

URL to check the output
 https://demo.cloud2ark.com/_cluster/health
