data "azurerm_client_config" "current" {
}




resource "azurerm_key_vault" "kvs" {
  for_each = var.keyvaults

  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name                        = each.value.sku_name
  enabled_for_deployment          = each.value.enabled_for_deployment
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  rbac_authorization_enabled      = each.value.rbac_authorization_enabled
  public_network_access_enabled   = each.value.public_network_access_enabled

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = each.value.access_policy.key_permissions

    secret_permissions = each.value.access_policy.secret_permissions

    storage_permissions = each.value.access_policy.storage_permissions
  }
}
