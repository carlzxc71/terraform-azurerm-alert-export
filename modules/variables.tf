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

variable "schedule" {
  description = "The schedule that the Runbook in the Automation Account will use"
  type = object({
    day        = string
    occurrence = number
  })
  default = {
    day        = "Monday"
    occurrence = 1
  }
}