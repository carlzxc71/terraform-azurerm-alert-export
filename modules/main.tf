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