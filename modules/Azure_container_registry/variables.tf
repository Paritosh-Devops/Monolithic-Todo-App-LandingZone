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
