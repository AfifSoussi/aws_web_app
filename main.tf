module "elastic-web-app" {
    source = "./elastic-web-app"
}


output "Load-Balancer-Hostname" {
  value =    module.elastic-web-app.Load-Balancer-Hostname
}
