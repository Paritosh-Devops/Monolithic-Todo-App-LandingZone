#variable  resource groups contains data types of all the arguments
variable "resource_groups" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

#variable  virtual networks contains data types of all the arguments
variable "virtual_networks" {
  type = map(object({


    name                           = string
    location                       = string
    resource_group_name            = string
    address_space                  = list(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    bgp_community                  = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string, "Disabled")
    subnets = optional(map(object({
      name             = string
      address_prefixes = list(string)
    })))

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
    tags = map(string)
  }))
}

variable "aks-cluster" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = optional(string)
    default_node_pool = list(object({
      name       = string
      node_count = number
      vm_size    = string
    }))
    identity = optional(list(object({
      type = string
    })))
    tags = optional(map(string))
  }))
}

variable "virtual_machines" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string

    subnet_name = string
    vnet_name   = string
    pip_name    = optional(string)

    ip_forwarding_enabled          = optional(bool, false)
    accelerated_networking_enabled = optional(bool, false)
    ip_configurations = map(object({
      name                          = string
      private_ip_address_allocation = string
      private_ip_address_version    = optional(string)
    }))
    vm_name        = string
    size           = string
    secret_name_un = string
    sec_name_pw    = string
    kv_name        = string
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




variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    tags = map(string)

  }))
}


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

variable "mssqls" {
  type = map(object({
  name                                 = string
  resource_group_name                  = string
  location                             = string
  version                              = string
  administrator_login                  = optional(string)
  administrator_login_password         = optional(string)
  minimum_tls_version                  = optional(string , "1.2")
  public_network_access_enabled        = optional(bool , true )
  outbound_network_restriction_enabled = optional(bool , false )

  tags = optional(map(string))
  }))
}

variable "sqldbs" {
  type = map(object({
    name         = string
    collation    = optional(string)
    license_type = optional(string)
    max_size_gb  = optional(number)
    sku_name     = optional(string)
    enclave_type = optional(string)
    mssqlserver_name = string
    resource_group_name = string
    tags = optional(map(string))
  }))
}



variable "acrs" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = optional( string , false )

    georeplications = optional(map(object({
      location                = optional(string)
      zone_redundancy_enabled = optional(string)
      tags                    = optional(map(string))
    })))


  }))
}


variable "secrets" {
  type = map(object({
    secret_name         = string
    secret_value        = string
    kv_name             = string
    resource_group_name = string
  }))
}
