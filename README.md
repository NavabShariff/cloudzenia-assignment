# AWS Infrastructure Setup

## Project Structure
This repository contains multiple tasks, each representing a different question assigned. The tasks are organized into separate folders:
- `task-1/`
- `task-2/`
- ...

Each task folder contains the required Terraform configurations.

# Task-1: ECS with ALB, RDS and SecretsManager
Inside `task-1/`, the Terraform implementation is structured as:

- `terraform-modules/` (modular Terraform approach)
- `terraform-plain/` (plain Terraform approach, used for deployment)

For this i used terraform-plain, modules setup partially completed...

### **Services Deployed in Task-1**

The following services were deployed using Terraform from `terraform-plain/`:
```
ls terraform-plain/

alb  ecs-cluster  ecs-iam  ecs-services  ecs-tasks  rds  s3  security-groups  vpc-network

```
Deployment order:
1. **VPC Network**
2. **IAM Roles & Policies**
3. **Security Groups**
4. **RDS Database**
5. **ECS Cluster**
6. **Application Load Balancer (ALB)**
7. **ECS Tasks & Services**

## Best Practices Followed**:

* Implemented least privilege principles for IAM roles and security groups.
 
* Ensured code reusability by modularizing Terraform configurations.
 
* Code can be easily reusablility by updating variable names and backend statefile paths.

### **Deployment Links**
- **WordPress**: [https://wordpress.shariff.info](https://wordpress.shariff.info)
- **Microservice**: [https://microservice.shariff.info](https://microservice.shariff.info)

# Task-2: EC2 Instance with Domain Mapping and NGINX

Deployed two EC2 servers in the Mumbai region.

Used the same VPC network and the same load balancer from Task-1 to optimize costs.

## **Docker container deployment**
```
mkdir ~/nginx-html
```
```
echo "Namaste from Docker Container!" > ~/nginx-html/index.html 
```

```
docker compose -f task-2/docker-compose.yaml up -d
```

## **Deployment Links**

### **Instance URLs:**
- [https://ec2-alb-instance.shariff.info](https://ec2-alb-instance.shariff.info)
- [https://ec2-instance.shariff.info](https://ec2-instance.shariff.info)

### **Docker URLs:**
- [https://ec2-alb-docker.shariff.info](https://ec2-alb-docker.shariff.info)
- [https://ec2-docker.shariff.info](https://ec2-docker.shariff.info)

 
# Task-3: Observability (EC2 Metrics & Logs in CloudWatch)

### **Overview**  
- Configured CloudWatch to monitor RAM utilization on EC2 instance.  
- Configured CloudWatch to collect and store NGINX access logs.  

### **Terraform Code**  
- Terraform scripts for this task are available in the **`task-3`** folder.  


# Task-4: GitHub Actions (CI/CD for Microservice Deployment)

### **Overview**  
- A custom microservice is stored in a **GitHub repository**.  
- **GitHub Actions** is configured to:  
  - Build a Docker image  
  - Push the image to **ECR**  
  - Deploy the service to **ECS**  

### **GitHub Repository Link**  

[GitHub Repo for Task-4](#) *(https://github.com/NavabShariff/nodejs-microservice)*  
