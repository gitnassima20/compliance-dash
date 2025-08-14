output "backend_ecr_url" {
  value = module.ecr_backend.repository_url
}

output "frontend_ecr_url" {
  value = module.ecr_frontend.repository_url
}