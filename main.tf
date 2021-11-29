module "elastic-web-app" {
    source = "./elastic-web-app"
    vpc_cidr = "10.0.0.0/16"
    public_subnets_cidr =  "10.0.0.0/24"
    private_subnets_cidr = "10.0.1.0/24"
    environment = "dev"
    availability_zone = "eu-central-1a"

}

output "Load-Balancer-Hostname" {
  value =    module.elastic-web-app.Load-Balancer-Hostname
}




