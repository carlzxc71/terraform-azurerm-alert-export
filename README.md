## Create a solution to extract Azure Monitor Alerts

This Terraform module deploys an Azure Automation Account, Storage Account and a Runbook to extract Azure Monitor Alerts from the past 25 days, exporting this to a CSV and stores it in a file share in Azure Storage.

This is a module I created whilst in the process of learning to write Terraform and creating Terraform modules.

## Usage

```HCL
terraform {}

provider "azurerm" {
  features {}
}

module "alert_export" {
  source  = "carlzxc71/alert-export/azurerm"
  version = "1.0.1"

  rg_name              = "rg-alertexport-p-weu-001"
  aa_account_name      = "aa-alertexport-p-weu-001"
  storage_account_name = "stgalertexportpweu001"
  share_name           = "share01"
  storage_quota        = 5
  storage_dir_name     = "directory01"

  schedule = {
    day        = "Monday"
    occurrence = 1
  }
}
```

## Requirements

| Name                                                                      | Version       |
|---------------------------------------------------------------------------|---------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3        |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.50 |

## Providers

| Name                                                          | Version       |
|---------------------------------------------------------------|---------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.50 |



