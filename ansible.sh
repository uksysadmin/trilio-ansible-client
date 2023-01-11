#!/bin/bash
sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible python3-pip apt-transport-https ca-certificates curl
sudo pip install openshift PyYAML==5.4.1
ssh-keygen -t rsa -N "" -f .ssh/id_rsa
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh-keyscan localhost
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# TVO stuff
echo "deb [trusted=yes] https://apt.fury.io/triliodata-4-0/ /" | sudo tee /etc/apt/sources.list.d/trilio-fury.list
sudo apt-get update
sudo apt-get install -y python3-workloadmgrclient
