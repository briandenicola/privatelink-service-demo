resource "azurerm_key_vault_secret" "password" {
  name         = "vm-password"
  key_vault_id = var.azurerm_key_vault_id
  value        = random_password.password.result
}