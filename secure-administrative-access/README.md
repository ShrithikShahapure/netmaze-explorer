# 5.Secure Administrative Access

Implement an AWS Bastion Instance for secure and seamless RDP and SSH access to your virtual machines, ensuring you don't expose your VMs to the public internet.

### 1. Launch an EC2 Instance as bastion host
- Execute the following command to launch an EC-2 in the "office-public-subnet" of "office-vpc".
''' 
make init
'''

### 2. Launch into the On Prem EC-2
SSH into the on-prem-ec2 using the following commands:
(make sure you have your .pem file with you on your local device, when you ssh, do it in the same directory where you store your .pem file)

'''
chmod 400 all-projects.pem

ssh-add -K ./all-projects.pem

ssh -A -i all-projects.pem ec2-user@public-ip-of-the-on-prem-instance

'''

### 3. Launch into Bastion EC-2
- We are now in the On-prem shell. 
- Thanks to the VPN Tunnel we created, we can now directly log onto the bastion host from the on-prem terminal.
- Execute this command on the on-prem-shell

'''
ssh -A -i all-projects.pem ec2-user@public-ip-of-the-bastion-instance
'''

### 4. Launch into the private EC-2
- Now we are in the shell of the Bastion Host.
- We can now log into our private instances.
'''
ssh -A -i all-projects.pem ec2-user@private-ip-of-the-instance-you-want-to-access

'''
### 6. SSH into the Openswan EC-2.
- We have now successfully loged into the private ec2 using a bastion host.
- Now since we also have internet connectivity through NAT gateway, we can run the following commands to run a server on the private instances. (Do this for both web-app-1 and web-app-2 instances)

'''
sudo apt update

sudo apt install apache2

sudo ufw allow 'Apache'

sudo systemctl status apache2

cd /var/www/html

touch temp.html

rm index.html

mv temp.html index.html

nano index.html         //add the code from the /app/index.html on this repo to this file

'''

