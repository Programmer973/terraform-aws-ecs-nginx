![Terraform](https://img.shields.io/badge/Terraform-v1.6+-5F43E9?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Deployed-orange?logo=amazon-aws)
![ECS](https://img.shields.io/badge/ECS-Fargate-green?logo=amazon-ecs)

This project sets up a production-grade AWS infrastructure using Terraform, ECS Fargate, and an Application Load Balancer. The architecture is modular and deploys a containerized NGINX application across 3 Availability Zones in the eu-central-1 region.



# 🌍 AWS Scalable Infrastructure with Terraform  
*(Scroll down for 🇩🇪 Deutsch)*

This project demonstrates how to provision a **scalable, production-grade AWS infrastructure** using Terraform. It includes VPCs, subnets across multiple Availability Zones in `eu-central-1`, an Application Load Balancer, ECS Fargate, and full automation using IaC.

---

## 📐 Architecture Overview

![AWS Multi-AZ Diagram](./A_diagram_in_a_digital_format_illustrates_AWS_(Ama.png)

- Multi-AZ VPC with public and private subnets
- ALB for routing to Fargate containers
- ECS Cluster running NGINX
- IAM role, NAT gateways, and security groups
- 100% provisioned via Terraform

---

## 🛠 How to Use

```bash
cd environments/staging
terraform init
terraform apply -var-file="terraform.tfvars"
Copy the DNS name from the output and access it in your browser. You should see the default NGINX page.

🧼 Teardown
terraform destroy -var-file="terraform.tfvars"

🧠 What I Learned
Real-world IaC structure using modules

ECS, ALB, and IAM wiring with Terraform

Debugging container + target group integrations




🇩🇪 AWS Skalierbare Infrastruktur mit Terraform
Dieses Projekt zeigt, wie man mit Terraform eine vollständig skalierbare AWS-Infrastruktur aufbaut — inklusive VPC, ALB, ECS Fargate und automatisierter Bereitstellung.

📐 Architekturübersicht
![AWS Multi-AZ Diagramm](./A_diagram_in_a_digital_format_illustrates_AWS_(Ama.png)

VPC mit Subnetzen in 3 Availability Zones

ALB für HTTP-Traffic zu Fargate-Containern

ECS Cluster mit NGINX-Container

IAM Role, NAT Gateways, Sicherheitsgruppen

Komplett via Terraform automatisiert

🛠 Verwendung
bash
Copy
Edit
cd environments/staging
terraform init
terraform apply -var-file="terraform.tfvars"
Danach im Browser den DNS-Namen ausgeben lassen — du solltest die NGINX-Seite sehen.

🧼 Zerstören der Infrastruktur
bash
Copy
Edit
terraform destroy -var-file="terraform.tfvars"
🧠 Was ich gelernt habe
Reale Modulstruktur mit Terraform

ECS + ALB Anbindung in Code

IAM-Konfiguration + Debugging in AWS Console





