terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
        prevent_deletion_if_contains_resources = false
    }
  }
}

# Resource group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# App Service module
module "app_service" {
  source                  = "./modules/app_service"
  app_image               = "edenmor1989/restaurant-recommender:amd64"
  app_name                = var.app_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  storage_account_key     = module.database.storage_account_key
  storage_account_name    = module.database.storage_account_name
  restaurants_table_name  = "restaurants"
  logs_table_name         = "requestlogs"
}


# Cosmos DB module
# module "database" {
#   source              = "./modules/database"
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#   database_name       = var.database_name
# }
