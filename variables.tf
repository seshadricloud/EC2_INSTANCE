variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "keypair_name" {
  description = "Name for the key pair"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "user_data" {
  description = "User data for EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
}

variable "security_group_name" {
  description = "Name for the security group"
  type        = string
}
