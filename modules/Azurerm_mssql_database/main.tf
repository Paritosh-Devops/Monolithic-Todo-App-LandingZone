
resource "azurerm_mssql_database" "sqldb" {
  for_each     = var.sqldbs
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.sqlserver[each.key].id
  collation    = lookup(each.value, "collation", null)
  license_type = lookup(each.value, "license_type", null)
  max_size_gb  = lookup(each.value, "max_size_gb", null)
  sku_name     = lookup(each.value, "sku_name", null)
  enclave_type = each.value.enclave_type

  tags = each.value.tags

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
