variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security groups to attach to the EC2 instance"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for Amazon Linux"
  type        = string
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "rds_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-app-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "app-ec2-instance"
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "iam_role_name" {
  description = "IAM role name attached to EC2"
  value       = aws_iam_role.ec2_role.name
}
