# AWS + Terraform projects

In this project, I built upon the foundation of my previous work, expanding the functionality and deploying it in the cloud to create a more scalable, secure, and highly available system.  
By leveraging AWS services, I was able to enhance the infrastructure to handle increased traffic, improve fault tolerance, and automate key processes.  

(Docker project https://github.com/Yaelwil/DockerProject)

## AWS project

In this project, I designed and deployed a scalable and highly available cloud infrastructure using AWS services.  

Key components include-
- VPC and Subnets-  
Created a VPC with two public subnets for network isolation and secure routing.
- ALB-  
Set up an Application Load Balancer to evenly distribute traffic across EC2 instances for fault tolerance.
- Polybot Instances-  
Deployed two EC2 instances running an AI-based Polybot service, with redundancy to handle high traffic loads.
- SQS Queues-  
Configured two SQS queues for asynchronous messaging between services.
- DynamoDB-  
Implemented a DynamoDB table to store processed YOLO container data for fast, scalable storage.
- Auto-Scaling Groups-  
Set up auto-scaling groups to dynamically adjust instance count based on demand.
- Secrets Manager-  
Used AWS Secrets Manager for secure management of sensitive information like API keys.
- S3 Bucket-  
Integrated S3 for storing static files and large objects.
- IAM Roles & Policies-  
Assigned secure IAM roles with least-privilege policies to control access to AWS resources.
- Security Groups & ACLs-  
Defined strict inbound and outbound traffic rules for secure network access.
- KMS Key-  
Implemented encryption using AWS KMS to protect sensitive data.
- Self-Signed Certificate-  
Deployed SSL certificates to secure application communications.
- Launch Templates-  
Used launch templates for streamlined instance configuration and auto-scaling.

![AWS Project.jpeg](AWS%20Project.jpeg)


## Terraform Project
To streamline and automate the deployment of infrastructure while ensuring consistency across environments, I utilized Terraform to implement Infrastructure as Code (IaC).  

The key highlights of this project are:

- Self-Made Terraform Modules-  
I created reusable Terraform modules for each AWS resource, including  
VPC, subnets, EC2 instances, SQS, DynamoDB, ALB, IAM roles + policies, security groups, ACL, KMS key, self sign certificate, and launch template.  
These modules follow best practices, are highly parameterized, and allow easy deployment across multiple environments. 
- Multi-Region Deployment-  
The infrastructure is deployed across two AWS regions to enhance redundancy and fault tolerance. This ensures high availability and rapid recovery in case of a failure in one region.
- CI/CD Pipeline-  
  I implemented a partially automated CI/CD pipeline using tools like GitHub Actions, allowing for infrastructure changes to be easily managed and applied. However, I kept the apply and destroy operations manual, giving me control over when to provision or destroy resources to reduce costs.  
    Key aspects of the CI/CD pipeline include:
  - Automated Terraform Plan and Apply-  
  The pipeline automatically runs Terraform plan to validate changes, but requires manual approval before applying them, ensuring cost control and oversight. 
  - State Management-  
  The Terraform state is securely stored in an S3 backend with state locking enabled to prevent conflicting updates during concurrent runs. 
  - Cost-Conscious Management-  
  Instead of fully automating deployments, I designed the workflow to allow for selective apply or destroy commands, ensuring that resources are only provisioned when needed, which helps reduce cloud costs.

![Terraform project.jpeg](Terraform%20project.jpeg)