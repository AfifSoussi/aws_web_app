# Create a new load balancer
resource "aws_elb" "elb-public" {
  name = "${var.environment}-public-elb"
  subnets = [aws_subnet.public_subnet.id]
  security_groups = [aws_security_group.elb-sg.id]
  //instances                   = [aws_instance.test-private-server.id]
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


#Create Launch config
resource "aws_launch_configuration" "launch-config" {
  name_prefix   = "${var.environment}-launch-config"
 // image_id      =   data.aws_ami.ubuntu.id
   image_id = "ami-0bd99ef9eccfee250"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  security_groups = ["${aws_security_group.webserver-sg.id}"]
    root_block_device {
            volume_type = "gp2"
            volume_size = 20
            encrypted   = true
        }
    ebs_block_device {
           device_name = "/dev/sdg"
            volume_type = "standard"
            volume_size = 30
            encrypted   = true
           delete_on_termination = false
        }
lifecycle {
        create_before_destroy = true
     }
 	user_data = file("${path.module}/install_httpd.sh")
}




# Create Auto Scaling Group and attach it to target group
resource "aws_autoscaling_group" "autoscale-group" {
  name       = "${var.environment}-webapp-instance"
  desired_capacity   = 2
  max_size           = 5
  min_size           = 1
  force_delete       = true
  depends_on         = [aws_elb.elb-public]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.launch-config.name
  vpc_zone_identifier = [aws_subnet.private_subnet.id]
  
 tag {
       key                 = "Name"
       value               = "${var.environment}-webapp-instance"
       propagate_at_launch = true
    }
}

# attach the scalign group with the Load balancer
resource "aws_autoscaling_attachment" "attach-ELB-ASG" {
  elb = aws_elb.elb-public.id
  autoscaling_group_name = aws_autoscaling_group.autoscale-group.id
  depends_on   = [aws_elb.elb-public]
}


output "Load-Balancer-Hostname" {
  value = aws_elb.elb-public.dns_name
}

