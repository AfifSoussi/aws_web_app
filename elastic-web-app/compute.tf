# a server in the public subnet
resource "aws_instance" "test-public-server" {
	ami = "ami-0bd99ef9eccfee250"
	instance_type = "t2.nano"
	security_groups = [aws_security_group.webserver-sg.id]
	subnet_id = aws_subnet.public_subnet.id
  availability_zone       = "eu-central-1a" 
	user_data = file("${path.module}/install_httpd.sh")
    tags = {
    Name = "${var.environment}-public-vm"
    Environment = var.environment
    Access = "public"
  }
}

#a server in the private subnet with a load balancer
resource "aws_instance" "test-private-server" {
  ami = "ami-0bd99ef9eccfee250"
	instance_type = "t2.nano"
	security_groups = [aws_security_group.webserver-sg.id]
	subnet_id = aws_subnet.private_subnet.id
  availability_zone       = "eu-central-1a" 
	user_data = file("${path.module}/install_httpd.sh")
    tags = {
    Name = "${var.environment}-private-vm"
    Environment = var.environment
    Access = "private"
  }
}



# Create a new load balancer
resource "aws_elb" "elb-public" {
  name = "${var.environment}-public-elb"
  subnets = [aws_subnet.public_subnet.id]
  security_groups = [aws_security_group.elb-sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = [aws_instance.test-private-server.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300
  tags = {
    name = "${var.environment}-public-elb"
    Environment = var.environment
    Access = "public"
  }
}

output "ec2-private-elb-dns" {
  value = aws_elb.elb-public.dns_name
}

output "ec2-public-ip" {
  value = aws_instance.test-public-server.public_ip
}