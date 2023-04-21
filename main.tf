module "alert_export" {
  source = "./modules"

  rg_name              = "rg-alertexport-p-weu-001"
  aa_account_name      = "aa-alertexport-p-weu-001"
  storage_account_name = "stgalertexportpweu001"
  share_name           = "share01"
  storage_quota        = 5

  schedule = {
    day        = "Monday"
    occurrence = 1
  }
}