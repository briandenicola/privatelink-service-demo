resource "azurerm_cosmosdb_account" "this" {
  name                       = var.cosmos.name
  location                   = var.cosmos.location
  resource_group_name        = var.cosmos.resource_group_name
  offer_type                 = "Standard"
  kind                       = "GlobalDocumentDB"
  free_tier_enabled          = true
  automatic_failover_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.cosmos.location
    failover_priority = 0
  }
}

