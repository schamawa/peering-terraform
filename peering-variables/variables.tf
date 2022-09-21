variable "image_id" {
  type = string
  default = "ami-076e3a557efe1aa9c"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc1_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "vpc2_cidr" {
  type = string
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  type = string
  default = "10.10.3.0/24"
}

variable "subnet2_cidr" {
  type = string
  default = "172.16.10.0/24"
}

variable "zone" {
  type = string
  default = "ap-south-1a"
}

variable "zone1" {
  type = string
  default = "ap-south-1b"
}
