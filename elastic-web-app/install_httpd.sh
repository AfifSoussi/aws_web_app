#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<H1> Welcome ! </H1> <h2>Deployed via Terraform wih and Github Actions</h2>" | sudo tee /var/www/html/index.html