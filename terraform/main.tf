terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# 1. Configure AWS provider 
provider "aws" {
    region = var.aws_region
}

# 2. Get current AWS account ID to construct the ECR registry URL
data "aws_caller_identity" "current" {}

locals {
  ecr_registry = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}

# 3. Create ECR repositories for backend and frontend
module "ecr_backend" {
  source    = "./modules/ecr"
  repo_name = "my-backend-repo"
}

module "ecr_frontend" {
  source    = "./modules/ecr"
  repo_name = "my-frontend-repo"
}

# 4. Get ECR authorization tokens for Docker login
data "aws_ecr_authorization_token" "ecr" {}

# 5. Configure Docker provider with ECR authorization
provider "docker" {
  registry_auth {
    address  = local.ecr_registry
    username = data.aws_ecr_authorization_token.ecr.user_name
    password = data.aws_ecr_authorization_token.ecr.password
  }
}

# 6. Build and push Docker images
resource "docker_image" "backend" {
  name         = "${module.ecr_backend.repository_url}:${var.image_tag}"
  build {
    context    = "${path.module}/.."
    dockerfile = "backend/Dockerfile"
    build_args = {
      BUILDKIT_INLINE_CACHE = "1"
    }
  }
}

resource "docker_image" "frontend" {
  name         = "${module.ecr_frontend.repository_url}:${var.image_tag}"
  build {
    context    = "${path.module}/.."
    dockerfile = "frontend/Dockerfile"
    build_args = {
      BUILDKIT_INLINE_CACHE = "1"
    }
  }
}

# 7. Push Docker images to ECR
resource "docker_registry_image" "backend" {
  name          = docker_image.backend.name
  keep_remotely = true
}

resource "docker_registry_image" "frontend" {
  name          = docker_image.frontend.name
  keep_remotely = true
}