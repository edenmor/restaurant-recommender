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
variable "storage_account_key" {}
variable "storage_account_name" {}
variable "restaurants_table_name" {}
variable "logs_table_name" {}
