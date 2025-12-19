




#first fetch the keyvault where your secrets are kept ...

data "azurerm_key_vault" "keyvaults" {
  for_each            = var.virtual_machines
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "vm-username" {
  for_each     = var.virtual_machines
  name         = each.value.secret_name_un
  key_vault_id = data.azurerm_key_vault.keyvaults[each.key].id
}


data "azurerm_key_vault_secret" "vm-password" {
  for_each     = var.virtual_machines
  name         = each.value.sec_name_pw
  key_vault_id = data.azurerm_key_vault.keyvaults[each.key].id
}

resource "azurerm_network_interface" "nic" {
  for_each                       = var.virtual_machines
  name                           = each.value.nic_name
  location                       = each.value.location
  resource_group_name            = each.value.resource_group_name
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  accelerated_networking_enabled = each.value.accelerated_networking_enabled

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = try(data.azurerm_public_ip.publcip[each.key].id, null)
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
    }
  }
}

resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each                        = var.virtual_machines
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.vm-username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.vm-password[each.key].value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id, ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

}
