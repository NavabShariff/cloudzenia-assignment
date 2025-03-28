variable "region" {
    default = "ap-south-1"
}

variable "profile" {
    default = "default"
}

variable "vpc_name" {
    default = "cloudzenia-vpc"
}

variable "vpc_cidr" {
    default = "192.168.0.0/16"
}

variable "azs" {
    type = list
    default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public_subnet_cidr" {
    type = list
    default = ["192.168.0.0/20", "192.168.16.0/20"]
}

variable "public_subnet_names" {
    type = list
    default = ["public-subnet-1", "public-subnet-2"]
}

variable "private_subnet_cidr" {
    type = list
    default = ["192.168.48.0/20", "192.168.64.0/20"]
}

variable "private_subnet_names" {
    type = list
    default = ["private-subnet-1", "private-subnet-2"]
}

# nat

variable "enable_nat_gateway" {
  type    = bool
  default = true
}