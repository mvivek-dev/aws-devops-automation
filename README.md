DevOps Automation Project – Terraform + Python + CI/CD

This project is part of my DevOps assignment where I have used Terraform to provision AWS resources and a Python script to automate some operations over those resources. I have also set up a basic CI/CD pipeline using GitHub Actions to validate the Terraform code and Python scripts.

The focus was mainly on Infrastructure as Code, cloud automation using AWS SDK (boto3), and CI validation workflow.

Project Folder Structure
devops-assignment/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── modules/
│   │   ├── s3/
│   │   ├── rds/
│   │   └── ec2/
├── scripts/
│   └── app.py
├── tests/
│   └── test_dummy.py
├── .github/
│   └── workflows/
│       └── ci.yml
├── requirements.txt
├── .env.example
└── README.md

Part 1: Terraform Infrastructure

I wrote Terraform IaC code to provision the following AWS resources:

Resource	Service	Features Implemented
S3	Storage bucket	Versioning & lifecycle policy
RDS MySQL	Managed DB	Parameter group + Security group
EC2	App instance	IAM role + Instance profile attached

📌 Assignment did not require provisioning real infrastructure, so I only ran terraform init and terraform validate (mock setup).

Commands I used
cd terraform
terraform init
terraform validate
# terraform plan (only checked what would be created)

Part 2: Python Automation Script

Inside scripts/app.py, I automated multiple tasks using Python + AWS SDK (boto3) + MySQL driver (pymysql). The script does:

Task	Uses
Creates & uploads log file	S3 bucket
Lists objects from S3 to a text file	S3
Creates table, inserts, fetches data	RDS (MySQL)
Fetches EC2 instance metadata	EC2 API

💡 Since real AWS resources were not created, errors are handled gracefully and displayed in logs.

How I ran it locally
python -m venv .venv
source .venv/Scripts/activate   # Git Bash (Windows)

pip install -r requirements.txt

# Load env vars from .env (copied from .env.example)
set -a
source .env
set +a

python scripts/app.py


✔ Runs fully
✔ Shows logs for mock setup
✔ Good for assignment evaluation

Environment Setup (.env)

Template is provided in .env.example

AWS_REGION=ap-south-1
S3_BUCKET_NAME=my-logs-bucket-vivek-2025-mock

DB_HOST=mysql-rds-endpoint.amazonaws.com
DB_USER=appuser
DB_PASSWORD=SomePassword
DB_NAME=appdb

EC2_PRIVATE_IP=10.0.1.25


These values are placeholders since mock infra was used.

Part 3: CI/CD Pipeline

I added GitHub Actions workflow in:
.github/workflows/ci.yml

It performs:

Step	Tool
Lint Python code	flake8
Run tests	pytest
Validate Terraform config	terraform validate

✔ Runs automatically on push or pull request
✔ Helps avoid breaking the automation code

What I Learned

How to build Terraform modules for real-world cloud deployment

Using boto3 to interact with AWS services

Secure config handling using environment variables

Basic CI/CD workflow writing in YAML

Error handling when resources are not actually deployed

Future Improvements (if continued)

Actually deploy the infra (terraform apply)

Host app on EC2 + connect with real RDS DB

Push logs to S3 using CloudWatch agents

Add more unit tests and logging improvements

Conclusion

This assignment helped me integrate multiple DevOps tools together:

Terraform (Provision) + Python (Automate) + CI/CD (Validate)