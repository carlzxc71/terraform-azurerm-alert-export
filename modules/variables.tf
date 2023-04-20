variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-monitor-automation-001"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}

variable "aa_account_name" {
  description = "The name of the Automation Account"
  type        = string
  default     = "aa-alertexport-p-wue01"
}