










resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks-cluster
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  #A default_node_pool block as defined below
  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool
    content {
      name       = default_node_pool.value.name
      node_count = default_node_pool.value.node_count
      vm_size    = default_node_pool.value.vm_size
    }

  }

  dynamic "identity" {
    for_each = lookup(each.value, "identity", [])
    content {
      type = identity.value.type
    }

  }

  tags = each.value.tags
}
