variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for VPC"
  default     = "10.10.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  default     = "an-vpc"
}

variable "public_subnet_numbers" {
  type        = map(any)
  description = "Map of AZ to a number that should be used for public subnet"
  default = {
    sub1 = {
      az   = "eu-south-1a"
      cidr = "10.10.0.0/24"
    }
    sub2 = {
      az   = "eu-south-1b"
      cidr = "10.10.1.0/24"
    }
  }
}

variable "private_subnet_numbers" {
  type        = map(any)
  description = "Map of AZ to a number that should be used for public subnet"
  default = {
    sub1 = {
      az   = "eu-south-1a"
      cidr = "10.10.2.0/24"
    }
    sub2 = {
      az   = "eu-south-1b"
      cidr = "10.10.3.0/24"
    }
  }
}