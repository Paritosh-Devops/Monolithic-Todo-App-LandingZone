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