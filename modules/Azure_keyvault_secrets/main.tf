
variable "secrets" {
  type = map(object({
    secret_name         = string
    secret_value        = string
    kv_name             = string
    resource_group_name = string
  }))
}


data "azurerm_key_vault" "keyvaults" {
  for_each            = var.secrets
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}




resource "azurerm_key_vault_secret" "secrets" {
  for_each     = var.secrets
  name         = each.value.secret_name
  value        = each.value.secret_value
  key_vault_id = data.azurerm_key_vault.keyvaults[each.key].id
}
