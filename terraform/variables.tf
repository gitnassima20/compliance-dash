variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "image_tag" {
  description = "Tag for the Docker images (version or git commit hash)"
  type        = string
  default     = "latest"
}