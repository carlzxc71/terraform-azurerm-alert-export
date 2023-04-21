terraform {}

provider "azurerm" {
  features {}
}

module "alert_export" {
  source = "./modules"

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