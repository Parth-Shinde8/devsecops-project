variable "instance_type" {
  default = "t3a.medium"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "devops-key"
}