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

variable "storage_account_name" {
  description = "The name of the Storage Account"
  type        = string
  default     = "stgalertexportpweu001"
}

variable "share_name" {
  description = "The name of the File Share in the Storage Account"
  type        = string
  default     = "share01"
}

variable "storage_quota" {
  description = "The quota in GB for the Share"
  type        = number
  default     = 5
}

variable "storage_dir_name" {
  description = "The name of the Directory within the File Share"
  type        = string
  default     = "directory01"
}