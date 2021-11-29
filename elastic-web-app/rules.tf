/*==== VPC's Default Security Group ======*/
resource "aws_security_group" "default-sg" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Environment = var.environment
  }
}

# Create security group for load balancer
resource "aws_security_group" "elb-sg" {
  name        = "${var.environment}-elb-sg"
  description = "allow http inbound and everything outbound from the LB"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
 tags = {
    Name = "${var.environment}-elb-sg"
    Environment = var.environment
  } 
}
# Create security group for webserver
resource "aws_security_group" "webserver-sg" {
  name        = "${var.environment}-webserver-sg"
  description = "allow http/ssh inbound and everything outbound from the vms"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
   }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
     from_port = 2049
     to_port = 2049
     protocol = "tcp"
     cidr_blocks = [var.public_subnets_cidr]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
  name        = "${var.environment}-webserver-sg"
    Environment = var.environment
  }
}