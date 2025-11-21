variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "log-archival-policy"
    status = "Enabled"
    
    # Apply lifecycle rule to all objects in the bucket
    filter {
      prefix = ""
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

output "bucket_id" {
  description = "ID of the created S3 bucket"
  value       = aws_s3_bucket.this.id
}
