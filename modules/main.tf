data "local_file" "list_past_alerts_script" {
  filename = "./scripts/List-PastAlerts.ps1"
}

resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location

  tags = local.tags
}

resource "azurerm_automation_account" "this" {
  name                = var.aa_account_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "Basic"

  tags = local.tags
}

resource "azurerm_automation_runbook" "this" {
  name                    = "List-PastAlerts"
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  log_verbose             = true
  log_progress            = true
  description             = "This script will list alerts from Azure Monitor from the last 25 days"
  runbook_type            = "PowerShellWorkflow"

  content = data.local_file.list_past_alerts_script.content

  tags = local.tags
}

resource "azurerm_automation_schedule" "this" {
  name                    = "powershell-automation-schedule"
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  frequency               = "Month"

  monthly_occurrence {
    day        = var.schedule.day
    occurrence = var.schedule.occurrence
  }

  description = "Occurs once a month"
}

resource "azurerm_automation_job_schedule" "this" {
  schedule_name           = azurerm_automation_schedule.this.name
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  runbook_name            = azurerm_automation_runbook.this.name
}

resource "azurerm_automation_variable_string" "secret" {
  name                    = "accountKey"
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  value                   = "Temp Placeholder"
  encrypted               = true
  description             = "Account key for access to the storage account"
}

resource "azurerm_automation_variable_string" "secret" {
  name                    = "storageAccountName"
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  value                   = "Temp placeholder"
  encrypted               = true
  description             = "Account key for access to the storage account"
}