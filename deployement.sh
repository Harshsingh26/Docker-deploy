#!/bin/bash

echo "Updating your OS to latest OS..."
sudo apt-get update
sudo apt-get install -y ruby
sudo apt-get install wget
cd /home/ubuntu
echo "Refer https://docs.aws.amazon.com/codedeploy/latest/userguide/resource-kit.html#resource-kit-bucket-names"
echo "wget https://bucket-name.s3.region-identifier.amazonaws.com/latest/install"
# wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
# chmod +x ./install
# sudo ./install auto
sudo rm codedeploy-agent_1.2.0-1866_all.deb.*
sudo wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/releases/codedeploy-agent_1.2.0-1866_all.deb
sudo dpkg -i codedeploy-agent_1.2.0-1866_all.deb
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent

echo "Starting codepeployagent"
sudo service codedeploy-agent start

echo "Installing docker package..."
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install -y docker-ce

echo "starting Docker service.."
sudo service docker start

echo "Adding/providing ubuntu to docker group"
sudo usermod -a -G docker ubuntu

echo "Relogin to server so that ubuntu will update group"

echo "Install git package it is required in docker"
sudo apt-get install -y git

echo "Install all development tools in linux"
sudo apt-get install -y build-essential

sudo chmod 666 /var/run/docker.sock
sudo apt-get install -y awscli
$(aws ecr get-login --no-include-email --region ap-east-1)
docker kill $(docker ps -a -q)
docker system prune -a -f #Delete all images apart from last 5 images
docker pull 234588285849.dkr.ecr.ap-south-1.amazonaws.com/abc:qa
# docker run -itd -p 80:8000 --restart always 652388285849.dkr.ecr.ap-south-1.amazonaws.com/inventchat:qa

docker run -itd -p 80:8000 --env-file=.env --restart always 23563388285849.dkr.ecr.ap-west-1.amazonaws.com/abc:qa

# docker pull ${ECR}:${IMAGE_TAG}
# docker run -itd -p 80:3000 --restart always ${ECR}:${IMAGE_TAG}

docker ps





