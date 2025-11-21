output "s3_bucket_id" {
  value       = module.s3_bucket.bucket_id
  description = "ID of the S3 bucket"
}

output "rds_endpoint" {
  value       = module.rds_mysql.db_endpoint
  description = "Endpoint of the MySQL RDS instance"
}

output "rds_security_group_id" {
  value       = module.rds_mysql.db_security_group_id
  description = "Security group ID for the RDS instance"
}

output "ec2_instance_id" {
  value       = module.ec2_app.instance_id
  description = "ID of the EC2 instance"
}

output "ec2_private_ip" {
  value       = module.ec2_app.private_ip
  description = "Private IP of the EC2 instance"
}
