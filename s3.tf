resource "aws_s3_bucket" "bucket" {
  bucket        = "jenkins-bucket-with-terraform"
  force_destroy = true

}
