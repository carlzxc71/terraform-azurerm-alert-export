data "local_file" "list_past_alerts_script" {
  filename = "./scripts/List-PastAlerts.ps1"
}

data "azurerm_subscription" "primary" {}

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

  identity {
    type = "SystemAssigned"
  }

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
  runbook_type            = "PowerShell"

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

resource "azurerm_automation_variable_string" "storage_acc_name" {
  name                    = "storageAccountName"
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  value                   = "Temp placeholder"
  encrypted               = false
  description             = "Account key for access to the storage account"
}

resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_automation_account.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "monitor_reader" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_automation_account.this.identity[0].principal_id
}

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_share" "this" {
  name                 = var.share_name
  storage_account_name = azurerm_storage_account.this.name
  quota                = var.storage_quota
}

resource "azurerm_storage_share_directory" "this" {
  name                 = var.storage_dir_name
  share_name           = azurerm_storage_share.this.name
  storage_account_name = azurerm_storage_account.this.name
}