# Project Showcase Guide: Ansible + Terraform AWS Automation

This guide gives you everything you need to showcase this project to **recruiters, hiring managers, and on your portfolio / LinkedIn / GitHub**.

---

## 1. Resume Bullet Points (ATS-Optimized & Impact-Driven)

Copy and adapt these bullet points for your resume under **Projects** or **Work Experience**:

### Option A: Comprehensive DevOps / Cloud Engineer Format
> **AWS Infrastructure Automation & Scalable Web Platform** | *Terraform, Ansible, AWS, Nginx, Redis, Python*
> - Architected and deployed an automated, Multi-AZ cloud infrastructure in AWS (`ap-south-1`) utilizing modular Terraform, reducing provisioning time by **90%** with remote S3 backend state locking in DynamoDB.
> - Implemented automated configuration management and application deployment using **Ansible roles** and **AWS EC2 dynamic inventory plugins**, eliminating hardcoded IP dependencies and enabling automated server discovery.
> - Designed least-privilege security architectures with chained AWS Security Groups and IAM instance profiles with Systems Manager (SSM) integration, isolating the Redis cache tier in private subnets.
> - Configured an AWS Application Load Balancer (ALB) with Nginx reverse proxying and active `/healthz` health checking, achieving seamless multi-AZ traffic distribution and zero-downtime resilience.

### Option B: Concise Bullet Points
> - Engineered an automated, multi-tier AWS infrastructure across 2 Availability Zones using Terraform and Ansible.
> - Automated Nginx reverse proxy and Redis caching cluster deployments using modular Ansible roles.
> - Leveraged `amazon.aws.aws_ec2` dynamic inventory to resolve private IPs dynamically during playbook execution.
> - Implemented end-to-end health check telemetry on `/healthz` for automated ALB failover and traffic rerouting.

---

## 2. LinkedIn Post Template

Copy, customize, and post this on LinkedIn with screenshots or a short demo clip:

```text
🚀 Excited to share my latest Cloud & DevOps project: End-to-End Infrastructure Automation with Terraform & Ansible on AWS!

Modern cloud infrastructure demands both reproducible provisioning and scalable configuration management. In this project, I engineered a highly available, multi-tier web application deployed across multiple AWS Availability Zones.

🛠️ The Tech Stack:
• Infrastructure as Code: Terraform (Modular architecture, S3 Remote State + DynamoDB Locking)
• Configuration Management: Ansible (Roles, Jinja2 templating, Systemd automation)
• Cloud Provider: AWS (VPC, Multi-AZ Subnets, ALB, EC2, IAM SSM)
• Application Stack: Nginx Reverse Proxy, Gunicorn, Flask, Redis Cache

💡 Key Architectural Highlights:
1️⃣ Dynamic Server Discovery: Used the `amazon.aws.aws_ec2` dynamic inventory plugin to discover nodes via AWS tags—zero hardcoded IP addresses!
2️⃣ Principle of Least Privilege: Chained security groups ensure external traffic only hits the ALB, Web nodes only accept traffic from the ALB, and the Redis cache only listens to the Web tier.
3️⃣ Resilient Multi-AZ Load Balancing: The AWS ALB distributes client requests across AZs, while both nodes update an atomic, centralized Redis cache in real-time.
4️⃣ Deep Health Monitoring: Configured continuous `/healthz` checks verifying both the WSGI web process and live Redis connectivity before routing traffic.

Check out the full open-source codebase and architecture breakdown on GitHub:
👉 [Insert your GitHub Repository Link]

#DevOps #Terraform #Ansible #AWS #CloudArchitecture #InfrastructureAsCode #Python #Nginx #Redis
```

---

## 3. 2-Minute Demo Video Script (Loom / Screen Recording)

Record a short video (under 2 minutes) demonstrating the project:

| Time | Scene | Talking Points |
| :--- | :--- | :--- |
| **0:00 - 0:30** | Show Architecture Diagram in README | *"Hi everyone, today I'm presenting an automated multi-AZ cloud infrastructure on AWS built with Terraform and Ansible..."* Explain the VPC, ALB, 2 Web EC2s in separate AZs, and private Redis cache. |
| **0:30 - 0:50** | Show Terraform & Ansible Code | Highlight the modular Terraform structure (`modules/vpc`, `alb`, `compute`) and the Ansible dynamic inventory (`aws_ec2.yml`) that discovers nodes by tag. |
| **0:50 - 1:20** | Show Live Web Application | Open the ALB public DNS in the browser. Show the responsive UI displaying: Serving EC2 Node (`ip-10-0-1-29`), Private IP, Redis connection status (`Connected`), and the shared hit counter. |
| **1:20 - 1:45** | Refresh to Show Multi-AZ Load Balancing | Hit refresh. Show that the Responding Node flips between AZ-A (`ip-10-0-1-29`) and AZ-B (`ip-10-0-2-122`), while the Redis visitor count continues incrementing atomically. |
| **1:45 - 2:00** | Conclusion & Teardown | Highlight zero-downtime health checking on `/healthz` and clean teardown via `terraform destroy`. |

---

## 4. DevOps Interview Deep-Dive Cheat Sheet

Be prepared to answer these common interview questions:

### Q1: "Why did you use BOTH Terraform and Ansible instead of just one?"
> **Answer**: *"I followed the industry standard 'Separation of Concerns': Terraform excels at orchestrating cloud infrastructure state (VPC, Subnets, ALB, Security Groups, IAM), while Ansible excels at configuration management and application lifecycle (packages, templating config files, systemd services). Combining both gives the flexibility of dynamic cloud resources with idempotent, readable server configurations."*

### Q2: "How did Ansible know the IP addresses of newly created EC2 instances without hardcoding?"
> **Answer**: *"I used Ansible's `amazon.aws.aws_ec2` dynamic inventory plugin. Instances are tagged by Terraform with `Role=web`, `Role=redis`, and `Environment=dev`. When Ansible runs, it queries AWS APIs to discover running instances and automatically groups them into `@tag_Role_web` and `@tag_Role_redis`. Furthermore, the web application dynamically extracts the Redis private IP via Jinja2 host variable mapping (`groups['tag_Role_redis']`)."*

### Q3: "How did you secure the Redis instance?"
> **Answer**: *"Security in depth: First, Redis was isolated at the network layer using security group chaining—its security group only allows inbound traffic on port 6379 from the Web Security Group. Second, password authentication (`requirepass`) was enforced via Jinja2 templates. Third, all instances use IAM instance profiles with `AmazonSSMManagedInstanceCore`, avoiding the need for open public SSH ports."*

### Q4: "How does the Load Balancer ensure users don't hit an unhealthy instance?"
> **Answer**: *"We configured a custom `/healthz` endpoint. Unlike a shallow check that only tests if port 80 is listening, our endpoint actively checks if the Flask application is running AND successfully executes a `r.ping()` against the Redis database. If Redis or the app fails, it returns HTTP 503, causing the ALB to automatically drain traffic and route exclusively to the healthy node."*

---

## 5. Next-Level Enhancements (To Stand Out Even More)

1. **Add a GitHub Actions CI/CD Pipeline**:
   - Run `terraform fmt -check`, `tflint`, and `ansible-lint` on every pull request.
2. **Add HTTPS / SSL**:
   - Request a free SSL certificate via AWS Certificate Manager (ACM) or configure Certbot on Nginx.
3. **Auto Scaling Group (ASG)**:
   - Convert the static 2-instance web tier into an AWS Auto Scaling Group backed by a Launch Template.