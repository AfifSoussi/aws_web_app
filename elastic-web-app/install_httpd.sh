#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start


sudo mount /dev/xvdg /var/log


echo "this is a test of log file" >> /var/log/log_test.log
sudo fdisk -l >> /var/log/log_test.log

#create web page with some content 
echo "<H1> Welcome ! </H1> <h2>Deployed via Terraform wih and Github Actions . EC2 worker IP : </h2>" | sudo tee /var/www/html/index.html
echo "<H2>" >> /var/www/html/index.html
hostname -I >> /var/www/html/index.html
echo "</h2><H3> Content of /var/log/log_test.txt </h3> <p>" >> /var/www/html/index.html
cat /var/log/log_test.log >> /var/www/html/index.html
echo "</p>" >> /var/www/html/index.html