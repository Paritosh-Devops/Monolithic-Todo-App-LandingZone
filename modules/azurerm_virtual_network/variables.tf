variable "virtual_networks" {
  type = map(object({


    name                           = string
    location                       = string
    resource_group_name            = string
    address_space                  = list(string)
    dns_servers                    = optional(list(string))
    bgp_community                  = optional(string)
    edge_zone                      = optional(string)
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
