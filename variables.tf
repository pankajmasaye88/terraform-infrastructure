variable "aws_region" {
  default = "ap-south-1"
}

variable "key_pair_name" {
  default = "docker-java.pem"
}

variable "public_key_path" {
  default = "/home/ubuntu/"
}

variable "instance_type" {
  default = "t3.micro"
}
