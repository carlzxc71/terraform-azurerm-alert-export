Just practicing creating Terraform Modules

```HCL
module "alert_export" {
  source = "./modules"

  rg_name = "walla"
}
```

