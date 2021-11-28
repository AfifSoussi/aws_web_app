module "elastic-web-app" {
    source = "./elastic-web-app"
}


output "ec2-private-elb-dns" {
  value =    module.elastic-web-app.ec2-private-elb-dns
}

output "ec2-public-ip" {
   value =    module.elastic-web-app.ec2-public-ip
}