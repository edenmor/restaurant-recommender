variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The location for the resources"
  type        = string
}

variable "app_name" {
  description = "The name of the app"
  type        = string
}

variable "app_image" {
  description = "The Docker image for the app"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "restaurants_table_name" {
  description = "The name of the restaurants table"
  type        = string
}

variable "logs_table_name" {
  description = "The name of the logs table"
  type        = string
}
variable "azure_client_id" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
