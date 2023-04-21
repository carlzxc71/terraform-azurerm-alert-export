output "automation_account_name_output" {
  value = azurerm_automation_account.this.name
  description = "Outputting the name of the atomation account"
}