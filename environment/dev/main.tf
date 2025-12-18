
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call resouce group child module 

module "resource_group" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups

}


#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call resouce vnet child module 

module "virtual_networks" {
  depends_on       = [module.resource_group]
  source           = "../../modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
}

#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call aks cluster child module 

module "aks_cluster" {
  depends_on  = [module.resource_group]
  source      = "../../modules/azure_kubernates_services"
  aks-cluster = var.aks-cluster

}

#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call virtual machine child module 

module "virtual_machines" {
  depends_on       = [module.resource_group, module.public_ip, module.virtual_networks]
  source           = "../../modules/Azure_linux_virtual_machine"
  virtual_machines = var.virtual_machines
}

#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call public ip child module 

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/Azure_public_ip"
  public_ips = var.public_ips
}

#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call key vault child module 

module "keyvault" {
  depends_on = [ module.resource_group ]
  source = "../../modules/Azure_key_vault"
  keyvaults = var.keyvaults
}

#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call mssql child module 

module "mssqls" {
  depends_on = [ module.resource_group ]
  source = "../../modules/Azure_mssql_server"
  mssqls = var.mssqls
}
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# call mssql database child module 

module "mssqldatabase" {
  depends_on = [ module.mssqls ]
  source = "../../modules/Azurerm_mssql_database"
  sqldbs = var.sqldbs
}


#call ACR

module "acr" {
  depends_on = [ module.resource_group ]
  source = "../../modules/Azure_container_registry"
  acrs = var.acrs
}

#======================================================
#Define your secrets here 

module "secrets" {
  depends_on = [ module.keyvault ]
  source = "../../modules/Azure_keyvault_secrets"
  secrets = var.secrets
}