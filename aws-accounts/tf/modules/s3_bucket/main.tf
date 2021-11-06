resource "aws_s3_bucket" "tf_state" {
  bucket = var.name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }
}
