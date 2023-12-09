#!/bin/bash

sudo yum update -y 
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker stop website || true
sudo docker rm website || true
sudo docker pull lyndaaaudrey/website-repo:latest
sudo docker run -d --name website -p 80:80 lyndaaaudrey/website-repo:latest
