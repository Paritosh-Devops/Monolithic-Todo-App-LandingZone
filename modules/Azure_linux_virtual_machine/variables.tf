variable "virtual_machines" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string

    subnet_name                    = string
    vnet_name                      = string
    pip_name                       = optional(string)
   
    ip_forwarding_enabled          = optional(bool , false)
    accelerated_networking_enabled = optional(bool , false)
    ip_configurations = map(object({
      name                          = string
      private_ip_address_allocation = string
      private_ip_address_version    = optional(string)
    }))
    vm_name        = string
    size        = string
    secret_name_un = string
    sec_name_pw = string
    kv_name = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))

}
