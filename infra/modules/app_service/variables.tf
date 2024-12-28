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
