output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = module.database.storage_account_name
}

output "storage_account_key" {
  description = "Access key for the Azure Storage Account"
  value       = module.database.storage_account_key
}

output "restaurants_table_name" {
  description = "Name of the Restaurants Table"
  value       = module.database.restaurants_table_name
}

output "logs_table_name" {
  description = "Name of the Logs Table"
  value       = module.database.logs_table_name
}
