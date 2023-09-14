# 7. Performance and Security Testing

- Now your complete infra should be set up.
- Let's perform some tests to verify everything works.

### 1. Ping On-Prem instance from web-app-1 Instance
- SSH into the On-Prem instance using the command :
```
ssh -A -i all-projects.pem ec2-user@public-ip-of-the-on-prem-instance
```

- SSH into the Bastion instance using the command :
```
ssh -A -i all-projects.pem ec2-user@public-ip-of-the-bastion-instance
```

- SSH into the Bastion instance using the command :
```
ssh -A -i all-projects.pem ec2-user@public-ip-of-the-bastion-instance
```

- SSH into the Private web-app-1 instance using the command :
```
ssh -A -i all-projects.pem ec2-user@private-ip-of-the-web-app-1-instance
```

- Once you're on the shell of web-app-1, execute:
```
ping public-ip-of-the-on-prem-instance
```
- If done successfully, you should be able to ping the on-prem instance.



### 2. Check if site is deployed.
- Go to the Elastic load balancer on the GUI.
- Click the end point shown on the site.
- If steps were followed properly,  you should be able to see the index.html site on your web browser.

