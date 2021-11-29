
variable "vpc_cidr" {
  description = "vpc range"
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "public range"
  default = "10.0.0.0/24"
}

variable "private_subnets_cidr" {
  description = "private range"
  default = "10.0.1.0/24"
}

variable "environment" {
  description = "to deploy multiple times"
  default = "dev"
}


variable "availability_zone" {
  description = "az to use"
  default = "eu-central-1a"
}