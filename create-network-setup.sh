#!/bin/bash


#for this project i'll be creating two vpc; one for the main network and the other one to simulate the on prem network
#the on prem vpc is created with aws gui console
#we will create the office network with the help of aws cli

#go to GUI and edit name to network-sim-office-vpc
aws ec2 create-vpc \
--cidr-block 19.0.0.0/16 \
--output json > network-sim-office-vpc.json


#stores vpc-id of office
vpc_id=$(echo "$network-sim-office-vpc.json" | grep -o '"VpcId": "[^"]*"' | sed 's/"VpcId": "//')


#go to gui and change subnet name to network-sim-office-public-us-east-1a
# this returns all outputs in json
aws ec2 create-subnet \
--vpc-id "$vpc_id" \
--cidr-block 19.0.0.0/20 \
--availability-zone us-east-1a \
--output json > network-sim-office-public-subnet.json

subnet_id_public=$(echo "$network-sim-office-public-subnet.json" | grep -o '"SubnetId": "[^"]*"' | sed 's/"SubnetId": "//')
 
#change name to network-sim-office-igw
aws ec2 create-internet-gateway \░
--output json > network-sim-office-igw.json

igw_id=$(echo "$network-sim-office-igw.json" | grep -o '"InternetGatewayId": "[^"]*"' | sed 's/"InternetGatewayId": "//')


#from output of igw, attatch igw gateway to network-sim-office-vpc
aws ec2 attach-internet-gateway \
--internet-gateway-id "igw_id" \
--vpc-id  "$vpc_id"



#go to gui and change subnet name to network-sim-office-private-web-app-1-subnet-us-east-1a
# this returns all outputs in json
#this is for web app subnet
aws ec2 create-subnet \
--vpc-id  "$vpc_id" \
--cidr-block 19.0.128.0/20 \
--availability-zone us-east-1a \
--output json > network-sim-office-private-web-app-1-subnet-us-east-1a.json

subnet_id_web_app_1=$(echo "$network-sim-office-private-web-app-1-subnet-us-east-1a.json" | grep -o '"SubnetId": "[^"]*"' | sed 's/"SubnetId": "//')



#go to gui and change subnet name to network-sim-office-private-web-app-2-subnet-us-east-1b
# this returns all outputs in json
#this is for web app subnet
aws ec2 create-subnet \
--vpc-id  "$vpc_id" \
--cidr-block 19.0.16.0/20 \ 
--availability-zone us-east-1b \
--output json > network-sim-office-private-web-app-2-subnet-us-east-1b.json

subnet_id_web_app_2=$(echo "$network-sim-office-private-web-app-2-subnet-us-east-1b.json" | grep -o '"SubnetId": "[^"]*"' | sed 's/"SubnetId": "//')





#go to gui and change subnet name to network-sim-office-private-data-1-subnet-us-east-1a
# this returns all outputs in json
#this is for data subnet
aws ec2 create-subnet \
--vpc-id  "$vpc_id" \
--cidr-block 19.0.32.0/20 \
--availability-zone us-east-1a \
--output json > network-sim-office-private-data-1-subnet-us-east-1a.json

subnet_id_data_1=$(echo "$network-sim-office-private-data-1-subnet-us-east-1a.json" | grep -o '"SubnetId": "[^"]*"' | sed 's/"SubnetId": "//')




#go to gui and change subnet name to network-sim-office-private-data-2-subnet-us-east-1b
# this returns all outputs in json
#this is for the private data subnet
aws ec2 create-subnet \
--vpc-id  "$vpc_id" \
--cidr-block 19.0.166.0/20 \
--availability-zone us-east-1b \
--output json > network-sim-office-private-data-2-subnet-us-east-1b.json

subnet_id_data_2=$(echo "$network-sim-office-private-data-2-subnet-us-east-1b.json" | grep -o '"SubnetId": "[^"]*"' | sed 's/"SubnetId": "//')



# Print the value of vpc-id
echo "VpcId: $vpc_id"
echo "public-subnet-id: $subnet_id_public"
echo "internet-gateway-id: $igw_id"
echo "web-app-1-subnet-id: $subnet_id_web_app_1"
echo "web-app-2-subnet-id: $subnet_id_web_app_2"
echo "data-1-subnet-id: $subnet_id_data_1"
echo "data-2-subnet-id: $subnet_id_data_2"




rm -rf *.json
