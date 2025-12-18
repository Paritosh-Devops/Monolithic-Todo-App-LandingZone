resource "azurerm_virtual_network" "vnet" {
  for_each                       = var.virtual_networks
  name                           = each.value.name
  location                       = each.value.location
  resource_group_name            = each.value.resource_group_name
  address_space                  = each.value.address_space
  dns_servers                    = each.value.dns_servers
  bgp_community                  = each.value.bgp_community
  edge_zone                      = each.value.edge_zone
  flow_timeout_in_minutes        = each.value.flow_timeout_in_minutes
  private_endpoint_vnet_policies = each.value.private_endpoint_vnet_policies

  dynamic "subnet" {
    for_each = each.value.subnets #== null ? {} : each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan == null ? [] : [each.value.ddos_protection_plan]
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption == null ? [] : [each.value.encryption]
    content {
      enforcement = encryption.value.enforcement

    }
  }
  tags = each.value.tags
}
