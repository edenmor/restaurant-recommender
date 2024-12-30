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
}

output "app_url" {
  value = azurerm_app_service.main.default_site_hostname
}

resource "azurerm_app_service" "main" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id
  site_config {
    always_on         = true
    app_command_line  = "gunicorn -w 4 -b 0.0.0.0:80 app.api:app"
    linux_fx_version  = "DOCKER|edenmor1989/restaurant-recommender:latest"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITES_PORT                       = "80"
    STORAGE_ACCOUNT_NAME                = var.storage_account_name
    STORAGE_ACCOUNT_KEY                 = var.storage_account_key
    RESTAURANTS_TABLE_NAME              = var.restaurants_table_name
    LOGS_TABLE_NAME                     = var.logs_table_name
  }
  depends_on = [ azurerm_app_service_plan.main ]
}
