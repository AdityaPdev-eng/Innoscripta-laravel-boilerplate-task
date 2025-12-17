variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "innoscripta-eks"
}

variable "cluster_version" {
  default = "1.29"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}
