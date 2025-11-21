module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "rds_mysql" {
  source        = "./modules/rds"
  db_name       = var.db_name
  db_username   = var.db_username
  db_password   = var.db_password
  vpc_id        = var.vpc_id
  db_subnet_ids = var.db_subnet_ids
}

module "ec2_app" {
  source                 = "./modules/ec2"
  instance_type          = var.ec2_instance_type
  subnet_id              = var.ec2_subnet_id
  vpc_security_group_ids = var.ec2_security_group_ids
  ami_id                 = var.ec2_ami_id
}
