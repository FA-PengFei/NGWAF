output "arn" {
    value = aws_s3_bucket.module_bucket.arn
}

output "id" {
    value = aws_s3_bucket.module_bucket.id
}

output "bucket_name" {
    value = var.bucketname
}