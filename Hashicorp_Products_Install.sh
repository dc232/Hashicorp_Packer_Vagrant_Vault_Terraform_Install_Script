#!/bin/bash
############################################
#Global variables
############################################
#PACKER_CHECK=$(ls -l /usr/bin | grep packer)  --> old style code see shellcheck.com SC2010
#TERRAFORM_CHECK=$(ls -l /usr/bin | grep terraform) --> old style code see shellcheck.com SC2010
#VAULT_CHECK=$(ls -l /usr/bin | grep vault) --> old style code see shellcheck.com SC2010

#the checks below are better examples than SC2010 it aviods errounous information in standard out
#we can use * to glob everything in the dir but as we are looking for spefic files we do not need *packer*
#for example



#PACKER_CHECK=$(find /usr/bin -type f -name "packer" -ls)
PACKER_CHECK=$(which packer)
#TERRAFORM_CHECK=$(find /usr/bin -type f -name "terraform" -ls)
TERRAFORM_CHECK=$(which terraform)
#VAULT_CHECK=$(find /usr/bin -type f -name "vault" -ls)
VAULT_CHECK=$(which vault)
CONSUL_BIN=$(which consul)
CONSUL_VER=$(curl https://releases.hashicorp.com/consul/ | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed -n '1p' | sed -e 's/[ \t]*//' | sed 's/terraform//g' | sed 's/"//g' |  sed -e 's/[ \t]*//' | sed -e 's#/$##' | sed 's/>//2' | sed 's/^.*_//' | sed 's/<//' | sed 's/a//' | sed -e 's#/$##')
PACKER_VERSION=$(curl https://releases.hashicorp.com/packer/ | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed -n '1p' | sed -e 's/[ \t]*//' | sed 's/terraform//g' | sed 's/"//g' |  sed -e 's/[ \t]*//' | sed -e 's#/$##' | sed 's/>//2' | sed 's/^.*_//' | sed 's/<//' | sed 's/a//' | sed -e 's#/$##')
VAULT_VERSION=$(curl https://releases.hashicorp.com/vault/ | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed -n '1p' | sed -e 's/[ \t]*//' | sed 's/terraform//g' | sed 's/"//g' |  sed -e 's/[ \t]*//' | sed -e 's#/$##' | sed 's/>//2' | sed 's/^.*_//' | sed 's/<//' | sed 's/a//' | sed -e 's#/$##')
TERRAFORM_VERSION=$(curl https://releases.hashicorp.com/terraform/ | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed -n '1p' | sed -e 's/[ \t]*//' | sed 's/terraform//g' | sed 's/"//g' |  sed -e 's/[ \t]*//' | sed -e 's#/$##' | sed 's/>//2' | sed 's/^.*_//' | sed 's/<//' | sed 's/a//' | sed -e 's#/$##')
PWD=$(pwd)
#https://unix.stackexchange.com/questions/323203/check-if-multiple-directories-exist-with-bash-script

CONSUL () {
  if [ "$CONSUL_BIN" ]; then 
  echo "Consul binary found proceeding to verify install"
  consul -v
  UNZIP_INSTALLED=$(which unzip)
  elif [ "$UNZIP_INSTALLED" ]; then
  echo "Unzip installation found downloading Consul"
  sleep 1
  wget https://releases.hashicorp.com/consul/$CONSUL_VER/consul_"$CONSUL_VER"_linux_amd64.zip
  sudo unzip consul_"$CONSUL_VER"_linux_amd64.zip -d /usr/bin
  consul -v
  else
  echo "Installing consul binary and unzip"
  sleep 1
  sudo apt install unzip -y
  wget https://releases.hashicorp.com/consul/$CONSUL_VER/consul_"$CONSUL_VER"_linux_amd64.zip
  sudo unzip consul_"$CONSUL_VER"_linux_amd64.zip -d /usr/bin
  consul -v
  fi
}

Packer () {
    cat << EOF
############################################
Retriving Packer package 
############################################
EOF

if [ "$PACKER_CHECK" ]; then
echo "verifying packer installation"
sleep 1
packer version
elif [ "$UNZIP_INSTALLED" ]; then
wget https://releases.hashicorp.com/consul/$PACKER_VERSION/consul_"$PACKER_VERSION"_linux_amd64.zip
sudo unzip packer_"$PACKER_VERSION"_linux_amd64.zip -d /usr/bin
echo "Checking packer installation"
sleep 1
packer version
else
echo "Installing Packer binary and unzip"
sleep 1
sudo apt install unzip -y
wget https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_"$PACKER_VERSION"_linux_amd64.zip
sudo unzip packer_"$PACKER_VERSION"_linux_amd64.zip -d /usr/bin
packer version
echo "packer has not been downladed properly"
fi
}


Vault () {
    cat << EOF
############################################
Installing vault
############################################
EOF
sleep 2



if [ "$VAULT_CHECK" ]; then
echo "verifying vault installation"
sleep 1
vault -h
elif [ "$UNZIP_INSTALLED" ]; then
wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_"$VAULT_VERSION"_linux_amd64.zip
sudo unzip vault_"$VAULT_VERSION"_linux_amd64.zip -d /usr/bin
echo "Checking vault installation"
sleep 1
vault -h
else
echo "Installing vault binary and unzip"
sleep 1
sudo apt install unzip -y
wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_"$VAULT_VERSION"_linux_amd64.zip
sudo unzip vault_"$VAULT_VERSION"_linux_amd64.zip -d /usr/bin
echo "Checking Vault installation"
sleep 1
vault -h
fi
}

Terraform () {
    cat << EOF
############################################
Installing Terraform
############################################
EOF
sleep 2

#change the if statements around if they are not installed the finds will not find the file and hence move to the else statemet
  if [ "$TERRAFORM_CHECK" ]; then 
  echo "terraform binary found proceeding to verify install"
  terraform
  UNZIP_INSTALLED=$(which unzip)
  elif [ "$UNZIP_INSTALLED" ]; then
  echo "Unzip installation found downloading terraform"
  sleep 1
  wget https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip
  sudo unzip terraform_"$TERRAFORM_VERSION"_linux_amd64.zip -d /usr/bin
  terraform -v
  else
  echo "Installing terraform binary and unzip"
  sleep 1
  sudo apt install unzip -y
  wget https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip
  sudo unzip terraform_"$TERRAFORM_VERSION"_linux_amd64.zip -d /usr/bin
  terraform
  fi
}

packer_example_jason () {
    cat << EOF
############################################
Installing example packer script 
this can be found at 
https://www.packer.io/intro/getting-started/build-image.html
the file will be called example.json which will be
situated in the $PWD
############################################ 
EOF

sleep 2 

cat << EOF
############################################ 
For more information on the values used in the example.json file 
see https://www.packer.io/docs/builders/amazon-ebs.html which describes 
how to build a amazon-ebs image
For other type of builds such as amazon-instance or amazon-chroot see 
https://www.packer.io/docs/builders/amazon.html
For template functions 
https://www.packer.io/docs/templates/engine.html
############################################ 
EOF

sleep 10

#printf '/n' >> example.json
#sed -i -e '' example.json

#apply variables for aws_access_key and aws_secret_key

cat << EOF >>example.json
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": ""
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "us-east-1",
    "source_ami_filter": {
      "filters": {
      "virtualization-type": "hvm",
      "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",
      "root-device-type": "ebs"
      },
      "owners": ["099720109477"],
      "most_recent": true
    },
    "instance_type": "t2.micro",
    "ssh_username": "ubuntu",
    "ami_name": "packer-example {{timestamp}}"
  }]
}
EOF
cat << EOF
############################################ 
Validating packer file, please do not panic if this fails, 
this is becuase the aws_access_key and aws_secret_key have not 
been defined"
############################################ 
EOF
sleep 2
packer validate example.json
}

packer_example_jason_with_provisioner () {
    cat << EOF >>example.json
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": ""
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "us-west-2",
    "source_ami_filter": {
      "filters": {
      "virtualization-type": "hvm",
      "name": "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*",
      "root-device-type": "ebs"
      },
      "owners": ["099720109477"],
      "most_recent": true
    },
    "instance_type": "t2.micro",
    "ssh_username": "ubuntu",
    "ami_name": "packer-example {{timestamp}}"
  }],
  "provisioners": [{
    "type": "shell",
    "inline": [
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install -y redis-server"
    ]
  }]
}
EOF

cat << EOF
############################################ 
Validating packer file, please do not panic if this fails, 
this is becuase the aws_access_key and aws_secret_key have not 
been defined"
############################################ 
EOF

sleep 2
#the above example includes the reddis server on the image 
#by provisioning the image with it i.e it is baked into the AMI
#the AMI itself is stored in S3
packer validate example.json
}

terraform_example_jason () {
    cat << EOF
############################################
Installing example terraform script 
this can be found at 
https://www.terraform.io/intro/getting-started/build.html
the file will be called example.tf which will be
situated in the $PWD
############################################ 
EOF

sleep 2 

cat << EOF
############################################ 
For more information on the values used in the example.json file 
see https://www.terraform.io/docs/configuration/syntax.html which describes 
the Hasicorp Configuration Lanuage syntax neededed to set up the .ft (terraform)
or .tf.json file terraform json, it should be noted that you chould use the json
file format if the configuration was created by a machine 
it should also be noted that if the access_key and secret_key are not speficied
then terraform will look for saved API credentials possiblt in the ~/.aws/credentials
or IAM instance profile credentials
variables are defined here 
https://www.terraform.io/intro/getting-started/variables.html
############################################ 
EOF

sleep 20

    cat << EOF >>example.tf
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-west-2"
}
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
EOF

cat << EOF
############################################
initialising terraform for various 
local seeting and data to be used by
subsequent commands
please note the aws provider plugin will
be installed in a subdirectory in the 
cureent working direcotry as well other
book keeping files 
$PWD
############################################
EOF

sleep 10

terraform init
}

cat << EOF
############################################
This script is desighned  to installed the 
Packer, vault and Terraform binaries in 
the $PATH
############################################
EOF

sleep 4

cat << EOF 
############################################
the current paths for executing binaries
$PATH
############################################
EOF

sleep 2


cat << EOF 
############################################
the current paths for executing binaries
$PATH
############################################
EOF

Packer
Vault
Terraform
CONSUL
