variable "server" {
  type    = string
  default = "an-server-profile"
}

variable "instance_profile_name" {
  type    = string
  default = "server"
}

variable "role_name" {
  type    = string
  default = "an-server-iam-role"
}

variable "subnet-ids" {}

variable "security_group_ids" {}

variable "vpc_id" {}