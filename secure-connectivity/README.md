# 3.Secure Connectivity

For this step, we will be using the GUI. Log on to the web portal and follow along.

This step is to create a secure tunnel between the two VPCs to allow communication securely.

### 1. Create an OpenSwan/ CGW Instance
- This will be the OpenSwan/Customer Gateway.
- First, deploy an EC-2 in "network-sim-office-vpc" VPC and "network-sim-office-public-subnet-us-east-1a" Subnet.
- Use the "all-projects" Key Pair.
- It's also critical that you use the "amzn2-ami-kernel-5.10-hvm-2.0.20230906.0-x86_64-gp2" since this does not work on other AMIs.
- Enable public IP.
- After deploying, go to the EC-2 Dashboard. Select the instance, Actions > Networking > Stop Source/ destination check.


### 2. Create Customer Gateway
Go to VPC > Customer Gateway and create a CGW. Enter the public IP if the instance. 

### 3. Create Virtual Private Gateway
Go to VPC > Virtual Private Gateway and create a VPG. Once created, attatch it to the "network-sim-office-vpc" VPC.

### 4. Create Site to Site VPN
- Go to VPC > Create Site to Site VPN and create a Create Site to Site VPN.
- Select VPG created.
- Select CGW created.
- Select static routing and enter "15.0.0.0/16" and "19.0.0.0/16" .
- In local CIDR, enter "19.0.0.0/16" and in Remote CIDR, enter "15.0.0.0/16"
- Once created, go to the route table of the office-vpc and enable route propogation.
- Then download the OpenSwan configuration of the the VPN.



### 6. SSH into the Openswan EC-2.
SSH into the OpenSwan server using your preferred method. Most ideal would be the instance terminal. However, if you do the other methods, store the "all-projects" key on your device.

### 7. Setup Open Swan
Once you log on to the OpenSwan server, follow the steps that were listed on the OpenSwan configuration file:

- Before you start, run this command on the EC-2
```
yum install openswan -y
```
- Once you reach step 5, execute the following command:
```
systemctl start ipsec
systemctl status ipsec
```

### 8. Check 
- Once you do that, wait a few minutes and check the Site to Site VPN tab. Tunnel 1 should be activated.
- You can now communicate between both VPCs in a secure way.
