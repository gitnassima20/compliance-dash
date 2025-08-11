provider "aws" {
  region = var.aws_region
}

module "ecr_backend" {
  source    = "./modules/ecr"
  repo_name = "my-backend-repo"
}

module "ecr_frontend" {
  source    = "./modules/ecr"
  repo_name = "my-frontend-repo"
}