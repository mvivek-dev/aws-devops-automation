variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1" # Mumbai region
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID for placing RDS instance"
  type        = string
}

variable "db_subnet_ids" {
  description = "Subnets for RDS"
  type        = list(string)
}
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2_subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "ec2_security_group_ids" {
  description = "Security groups for the EC2 instance"
  type        = list(string)
}

variable "ec2_ami_id" {
  description = "AMI ID for Amazon Linux instance"
  type        = string
}
