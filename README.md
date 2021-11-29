# introduction :
this project goal is to deploy automatically a web application on AWS using Terraform
## Module :
the module will be independent and can be run on any account. 
i will add a terraform script around and a pipeline to deploy on my dev account.

## Architecture
![services and topologie](/architecture/images/arch.png "services and topologie")
## file structure :

    -main.tf

    -elastic_web_app/

            -network.tf

            -compute.tf

            -webapp.tf


## methodologies :
it's important to decompose the tasks into smaller parts, and do small inceremental deployments,
while testing the functionnalities newely introduced. 
eg : after deploying the networking infrastructure, i deploy 2 VMs (private +ELB / public) with a basic web server.
it allows to verify the E2E reachiblity with minimal testing efforts, before adding autoscaling. EFS, encryption etc...

![succesfull deployment](/architecture/images/network-server-test.png "succesfull deployment")


it can be helpful to destroy manually and re-apply with Terraform few times. some bugs can be avoided (AMI image change not taken into account), and some values who aren't hard coded can break the deployment if not in sync(AZ for the subnets and resources should be the same)
## steps :

- install Terraform v12
- create TF wrapper for the module
- create TF module (independent)
- prepare network infrastructure
--> Create VPC
--> create an internet gateway (contact internet , public)
--> create a NAT gateway (ec2 IPs, private)
--> create public subnet
--> create private subnet
--> create 2 route tables
--> associate subnets with route tables
- create security group
-->  allow http/s ports only through load balancers
-->  allow ssh to vm
-->  allow all egress traffic
-->  allow 2049 NFS for logs
- Create Load balancers (public subnet)
- Ceate a user data script for linux
--> install a web server
--> create a simple webpage
- (deploy quickly 2 ec2 instances to test connectivity)
- Create EBS for linux EC2 (encrypted)
- create EFS for Logs (encrypted/elastic)
- create a launch config or template on aws
- create autoscaling group
--> use linux AMI to scaling
--> create second volume * vms and mount /var/log
- create Cloudwatch integration/alarm

## documentation
-- write module architecture / input / output
-- draw architecture (miro ?)
-- write important decision

## questions :
No need for cloudfront ?
-management withtout a root key ??
-Storage / growth logs -> EFS dynamic elasticity / collect logs in cloudwatch and add deletion script.

