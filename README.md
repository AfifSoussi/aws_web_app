# introduction :
this project goal is to deploy automatically a web application on AWS using Terraform
## Module :
the module will be independent and can be run on any account. 
i will add a terraform script around and a pipeline to deploy on my dev account.
## steps :

- install Terraform v12
- create TF wrapper for the module
- create TF module (independent)
- Create VPC
-- create public subnet
-- create private subnet
- create EFS 
-- encrypted
--  dynamic elasticity
- Create Load balancers 
-- (inside public subnet)
- create a launch config or template on aws
- Create VMs 
-- (inside public subnet)
- create security group
--  allow http/s ports only through load balancers
--  allow ssh to vm
--  allow all ingress traffic

- create autoscaling group
-- use linux AMI to scaling
-- create second volume * vms and mount /var/log

- Ceate a user data script for linux
-- install a web server
-- create a simple webpage

- create Cloudwatch integration/alarm

## documentation
-- write module architecture / input / output
-- draw architecture (miro ?)
-- write important decision

## questions :
No need for cloudfront ?
-management withtout a root key ??
-Storage / growth logs -> EFS dynamic elasticity / collect logs in cloudwatch and add deletion script.

