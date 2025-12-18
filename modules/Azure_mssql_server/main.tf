


resource "azurerm_mssql_server" "mssqlserver" {
  for_each                             = var.mssqls
  name                                 = each.value.name
  resource_group_name                  = each.value.resource_group_name
  location                             = each.value.location
  version                              = each.value.version
  administrator_login                  = each.value.administrator_login
  administrator_login_password         = each.value.administrator_login_password
  minimum_tls_version                  = each.value.minimum_tls_version
  public_network_access_enabled        = each.value.public_network_access_enabled
  outbound_network_restriction_enabled = each.value.outbound_network_restriction_enabled

  tags = each.value.tags
}
