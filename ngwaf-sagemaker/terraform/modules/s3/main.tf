resource "aws_s3_bucket" "module_bucket" {
  bucket = "${var.bucketname}"
}

resource "aws_s3_bucket_public_access_block" "module_bucket_acl" {
    bucket = aws_s3_bucket.module_bucket.id
    block_public_acls = true
    block_public_policy = true
    restrict_public_buckets = true
    ignore_public_acls = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "module_bucket_encryption" {
  bucket = aws_s3_bucket.module_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "${var.kms_key_arn}"
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "module_bucket_versioning" {
  bucket = aws_s3_bucket.module_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}