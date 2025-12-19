   variable "aks-cluster" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = optional(string)
    default_node_pool = list(object({
      name       = string
      node_count = number
      vm_size    = string
    }))
    identity = optional(list(object({
      type = string
    })))
    tags     = optional(map(string))
  }))
}
