resource "azurerm_storage_account" "main" {
  name                     = "${var.database_name}store"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_blob_public_access = false
}

resource "azurerm_storage_table" "main" {
  name                = "restaurants"
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_table" "logs" {
  name                = "requestlogs"
  storage_account_name = azurerm_storage_account.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_account_key" {
  value = azurerm_storage_account.main.primary_access_key
}

output "restaurants_table_name" {
  value = azurerm_storage_table.main.name
}

output "logs_table_name" {
  value = azurerm_storage_table.logs.name
}
