terraform {
  backend "s3" {
    bucket = "terraform-state-adrean"
    key    = "s3-buckets/terraform.tfstate"
  }
}