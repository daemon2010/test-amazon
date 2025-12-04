variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "simple-vpc"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
  
  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "Public subnet CIDR must be a valid IPv4 CIDR block."
  }
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
  
  validation {
    condition     = can(cidrhost(var.private_subnet_cidr, 0))
    error_message = "Private subnet CIDR must be a valid IPv4 CIDR block."
  }
}