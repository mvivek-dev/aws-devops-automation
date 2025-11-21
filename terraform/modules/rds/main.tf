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

variable "db_instance_class" {
  description = "Instance class for MySQL RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB for the database"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "VPC ID where RDS will be placed"
  type        = string
}

variable "db_subnet_ids" {
  description = "Subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "allowed_cidr" {
  description = "CIDR range allowed to access MySQL"
  type        = string
  default     = "10.0.0.0/16"
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Security group for MySQL RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "rds-mysql-subnet-group"
  description = "Subnet group for MySQL RDS"
  subnet_ids  = var.db_subnet_ids
}

resource "aws_db_parameter_group" "this" {
  name        = "mysql-parameter-group"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "mysql-db-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.this.name

  skip_final_snapshot = true
  publicly_accessible = false
}

output "db_endpoint" {
  description = "Endpoint of the MySQL RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_security_group_id" {
  description = "Security group ID for the RDS instance"
  value       = aws_security_group.rds_sg.id
}
