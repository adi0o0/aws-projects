terraform {
  backend "s3" {
    bucket = "terraform-state-adrean"
    key    = "terraform.tfstate"
  }
}