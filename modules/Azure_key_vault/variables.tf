variable "keyvaults" {
  type = map(object({

    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool

    soft_delete_retention_days = number
    purge_protection_enabled   = optional(bool)

    sku_name = string
    enabled_for_deployment          = optional(bool)
    enabled_for_template_deployment = optional(bool)
    rbac_authorization_enabled      = optional(bool)
    public_network_access_enabled   = optional(bool, true )
    access_policy = optional(object({

      key_permissions     = optional(list(string))
      secret_permissions  = optional(list(string))
      storage_permissions = optional(list(string))

    }))

  }))


}
