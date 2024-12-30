variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_name" {
  description = "Name of the App Service"
  type        = string
}

variable "app_image" {
  description = "Docker image for the app"
  type        = string
}

variable "database_name" {
  description = "Name of the Cosmos DB database"
  type        = string
}

variable "storage_account_key" {
  type = string
}

variable "storage_account_name" {
  type = string
  default = "restaurantdbstore"
}

variable "restaurants_table_name" {
  type = string
  default = "restaurants"
}

variable "logs_table_name" {
  type = string
  default = "requestlogs"
}