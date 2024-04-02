output "APP_NAME" {
  value     = local.resource_name
  sensitive = false
}

output "AKS_NAME" {
  value     = module.application-stamp.AKS_CLUSTER_NAME
  sensitive = false
}

output "AKS_RESOURCE_GROUP" {
  value     = module.application-stamp.AKS_RESOURCE_GROUP
  sensitive = false
}

output "APP_SUBSCRIPTION_ID" {
  value     = var.dev_subscription
  sensitive = false
}
