module "alert_export" {
  source = "./modules"

  rg_name              = "rg-alertexport-p-weu-001"
  aa_account_name      = "aa-alertexport-p-weu-001"
  storage_account_name = "stgalertexportpweu001"

  schedule = {
    day        = "Monday"
    occurrence = 1
  }
}