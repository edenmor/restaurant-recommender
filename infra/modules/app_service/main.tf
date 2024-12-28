resource "azurerm_app_service_plan" "main" {
  name                = "${var.app_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    tier = "Free"
    size = "F1"
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
    always_on = true
    app_command_line = "gunicorn -w 4 -b 0.0.0.0:5000 app.api:app"
    linux_fx_version = "DOCKER|${var.app_image}"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}
