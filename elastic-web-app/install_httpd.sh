#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<H1> Welcome ! </H1> <h2>Deployed via Terraform wih and Github Actions . EC2 worker IP : </h2>" | sudo tee /var/www/html/index.html
echo "<H2>" >> /var/www/html/index.html
hostname -I >> /var/www/html/index.html
echo "</h2>" >> /var/www/html/index.html