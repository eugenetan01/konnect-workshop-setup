variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-06d753822bd94c64e" # Default to Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to use for the EC2 instance"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key file"
  type        = string
}

variable "compose_file_path" {
  description = "The path to the Docker Compose file"
  type        = string
}

variable "cert_file_path" {
  description = "The path to the certificate file"
  type        = string
}

variable "key_file_path" {
  description = "The path to the key file"
  type        = string
}

variable "prometheus_file_path" {
  description = "prometheus file path"
  type        = string
}
