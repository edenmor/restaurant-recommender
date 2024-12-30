terraform {
  backend "azurerm" {
    resource_group_name  = "restaurant-recommendation"
    storage_account_name = "restaurantdbstore"
    container_name       = "states"
    key                  = "terraform.tfstate"
  }
}


# Provider Configuration
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Tables
resource "azurerm_storage_table" "restaurants" {
  name                 = var.restaurants_table_name
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_table" "logs" {
  name                 = var.logs_table_name
  storage_account_name = azurerm_storage_account.main.name
}
resource "azurerm_app_service_plan" "main" {
  name                = "${var.app_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
  depends_on = [azurerm_resource_group.main]
}

resource "azurerm_app_service" "main" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id
  site_config {
    always_on         = true
    app_command_line  = "gunicorn -w 4 -b 0.0.0.0:80 app.api:app"
    linux_fx_version  = "DOCKER|${var.app_image}"
  }

  app_settings = {
    STORAGE_ACCOUNT_NAME      = var.storage_account_name
    STORAGE_ACCOUNT_KEY       = azurerm_storage_account.main.primary_access_key
    RESTAURANTS_TABLE_NAME    = var.restaurants_table_name
    LOGS_TABLE_NAME           = var.logs_table_name
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}

# Outputs
output "app_url" {
  value = azurerm_app_service.main.default_site_hostname
}
