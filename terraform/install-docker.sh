#!/bin/bash

sudo apt update
sudo apt install docker.io -y
sudo docker stop website || true
sudo docker rm website || true
sudo docker pull lyndaaaudrey/website-repo:latest
sudo docker run -d --name website -p 80:8080 lyndaaaudrey/website-repo:latest