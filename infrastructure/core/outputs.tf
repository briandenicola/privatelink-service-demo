output "CORE_RESOURCE_GROUP" {
  value     = azurerm_resource_group.this.name
  sensitive = false
}

output "CORE_VNET_PE_SUBNET_ID" {
  value     = azurerm_subnet.private-endpoints.id
  sensitive = false
}

output "CORE_ACR_DNS_ZONE_ID" {
  value     = azurerm_private_dns_zone.core_privatelink_azurecr_io.id
  sensitive = false
}

output "CORE_ACR_DNS_ZONE_NAME" {
  value     = azurerm_private_dns_zone.core_privatelink_azurecr_io.name
  sensitive = false
}
