resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-adrean"
}

resource "aws_s3_bucket" "apache-config" {
  bucket = "an-web-server"
}