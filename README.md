AWS DevOps Automation Project

Terraform + Python + GitHub Actions CI

This project is a part of my DevOps learning/assignment where I combined multiple tools:

Terraform → write Infrastructure-as-Code

Python Automation → interact with AWS services using boto3

GitHub Actions → run CI validation (Terraform + Python)

It helped me understand how DevOps workflows connect from development → automation → pipelines.

Project Overview
Component	Purpose
Terraform	Creates AWS infra (S3, RDS, EC2) using modules
Python Script	Uploads logs, lists S3 objects, DB CRUD, EC2 metadata
CI/CD Pipeline	Linting + Testing + Terraform validation

➡ Infra creation is mock-only (no real AWS deployment needed).
➡ Python script handles errors nicely if infra is not real.

Terraform Setup

Folder: terraform/
Resources defined using 3 modules:

modules/s3 → Versioning, lifecycle policy

modules/rds → MySQL RDS instance + SG + parameter group

modules/ec2 → Instance + IAM Role + S3/RDS access

Commands I used
cd terraform
terraform init
terraform validate
# terraform plan (for preview only)


Terraform state is NOT pushed — as required for mock setup.

Python Automation (scripts/app.py)

This script does 4 automation tasks:

Task	Service Used
Upload a log file to S3	S3
List S3 objects to a text file	S3
Create table + insert + select row	RDS MySQL
Fetch instance metadata	EC2 describe API

Uses environment variables for credentials/config.
All errors are logged properly instead of crashing (helpful in mock environment).

Running it locally
python -m venv .venv
source .venv/Scripts/activate  # Git Bash on Windows
pip install -r requirements.txt

# Load environment variables
set -a
source .env
set +a

python scripts/app.py


Since AWS resources are mocked → logs will show warnings like
NoSuchBucket, MySQL connection failed, etc.
➡ This is expected and shows error handling works.


Environment Variables

Copy .env.example → .env

AWS_REGION=ap-south-1
S3_BUCKET_NAME=my-logs-bucket-mock

DB_HOST=mysql.endpoint.local
DB_USER=appuser
DB_PASSWORD=somepassword
DB_NAME=appdb

EC2_PRIVATE_IP=10.0.1.25



CI/CD Pipeline (GitHub Actions)

File: .github/workflows/ci.yml

Pipeline job includes:

✔ Python dependency install
✔ Code lint (flake8)
✔ Tests (pytest)
✔ Terraform init + validate

Triggered automatically on push and pull requests

This ensures:

Code is formatted and import errors caught

Terraform configuration always stays valid

Python automation script is testable

📦 Requirements Installed
boto3
pymysql
flake8
pytest
