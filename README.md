# EC2 Infrastructure using Terraform

## 📌 Overview
This project demonstrates how to provision an AWS EC2 instance using Terraform with best practices like dynamic AMI selection, security groups, and Elastic IP.

---

## 🚀 What I Built

- Created an EC2 instance using Terraform
- Dynamically fetched the latest Amazon Linux 2023 AMI
- Configured Security Group with:
  - SSH (22)
  - HTTP (80)
  - HTTPS (443)
- Attached an Elastic IP for static public access
- Connected to EC2 via SSH

---

## 🧠 What I Learned

- Difference between **data** and **resource** in Terraform
- How to fetch latest AMI dynamically instead of hardcoding
- How Security Groups work (ingress vs egress)
- How to attach resources (SG, Key Pair, EIP) to EC2
- Terraform workflow:
  ```bash
  terraform init
  terraform plan
  terraform apply
