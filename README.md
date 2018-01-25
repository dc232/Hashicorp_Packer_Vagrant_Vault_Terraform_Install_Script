# Hashicorp_Packer_Vagrant_Vault_Terraform_Install_Script

This is a script that installs the following Hasicorp products on any Linux system into the binary executable path being /usr/bin :
Packer
Vault
Terraform

Vagrent is also installed but on the basis that you have a CentOS/Debian system

Versions installed 

PACKER_VERSION="1.1.3"
VAULT_VERSION="0.9.1"
TERRAFORM_VERSION="0.11.2"
VAGRANT_VERSION="2.0.1"


To install later versions please update the version variables and the script will do the rest

To execute the script 
1. install git on Debian you can run 

sudo apt-get update && sudo apt-get upgrade -y; sudo apt-get install git -y

on CentOS
sudo yum upgrade && sudo yum install git -y

2. git clone https://github.com/dc232/Hashicorp_Packer_Vagrant_Vault_Terraform_Install_Script.git
3. cd Hashicorp_Packer_Vagrant_Vault_Terraform_Install_Script
4. ./Hashicorp_Products_Install.sh

If you have any questions or have found bugs please raise as needed and I will do my best to address them
Also please feel free to make changes as nessecary to the script

Thank you for downloading this script and I hope its usefull for you
