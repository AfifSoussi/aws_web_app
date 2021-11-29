

/* will be used for elastic log mount on ec2
#----------- EFS FS ------------------

resource "aws_efs_file_system" "app-efs1" {
  creation_token = "${var.environment}-efs" 
  performance_mode = "generalPurpose"

  tags = {
    Name = "${var.environment}-efs"
    appname = "webapp"
  }
}


resource "aws_efs_mount_target" "app-mount-target" {
  file_system_id = aws_efs_file_system.app-efs1.id
  subnet_id      = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.webserver-sg.id]
  #ip_address = aws_instance.app-web.private_ip

}



resource "aws_efs_access_point" "app-efs_access_point" {
  file_system_id = aws_efs_file_system.app-efs1.id

}




output "efsip" {
    value = aws_efs_mount_target.app-mount-target.ip_address
    }
*/





/*  not used anymore, ASG attached to ELB 
# Create Target group
resource "aws_lb_target_group" "target-group" {
  name       = "${var.environment}-target-group"
  target_type = "instance"
  depends_on = [aws_vpc.vpc]
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}
*/

#a server in the private subnet with a load balancer
#used only for troubleshooting 
/*
resource "aws_instance" "test-private-server" {
	instance_type = "t2.nano"
  ami = "ami-0bd99ef9eccfee250"
	security_groups = [aws_security_group.webserver-sg.id]
	subnet_id = aws_subnet.private_subnet.id
  availability_zone       = var.availability_zone 
	user_data = file("${path.module}/install_httpd.sh")
    tags = {
    Name = "${var.environment}-private-vm"
    Environment = var.environment
    Access = "private"
  }
}

*/