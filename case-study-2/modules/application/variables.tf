variable "apache" {
  type    = string
  default = "an-apache-profile"
}

variable "apache_profile_name" {
  type    = string
  default = "apache"
}

variable "apache_role_name" {
  type    = string
  default = "an-apache-iam-role"
}

variable "launch_template" {
  type    = string
  default = "web-server"
}

variable "image_id" {
  type    = string
  default = "ami-0c96319db4545e18f"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "security_group_id" {}

variable "vpc_id" {}

variable "public_subnets" {}

variable "private_subnets" {}

variable "bucket_name" {
  type    = string
  default = "an-web-server"
}