data "azurerm_mssql_server" "sqlserver" {
  for_each = var.sqldbs
  name                = each.value.mssqlserver_name
  resource_group_name = each.value.resource_group_name
}