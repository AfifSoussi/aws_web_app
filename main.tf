resource "aws_s3_bucket" "test-bucket" {
  bucket = "creation-test-afif"
  acl = "private"
  tags = {
    deployed-by = "terraform"
  }
}