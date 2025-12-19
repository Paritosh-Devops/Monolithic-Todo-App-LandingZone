#Define your resource groups below
#----------------------------------------------------------------------
#----------------------------------------------------------------------

resource_groups = {
  rg01 = {
    name       = "dev-mono-pcsl-rg-01"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      environment = "dev"
      owner       = "ParitoshPany"
      costcenter  = "delhi006"
    }
  }
  rg02 = {
    name       = "dev-micro-pcsl-rg-02"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      environment = "dev"
      owner       = "ParitoshPany"
      costcenter  = "delhi006"
    }
  }
  rg03 = {
    name       = "dev-micro-pcsl-rg-03"
    location   = "eastus"
    managed_by = "terraform"
    tags = {
      environment = "dev"
      owner       = "ParitoshPany"
      costcenter  = "delhi006"
    }
  }
}

#Define your virtual networks & subnets below
#----------------------------------------------------------------------
#----------------------------------------------------------------------

virtual_networks = {
  vnet01 = {
    name                           = "pcslmonovnet01"
    location                       = "centralindia"
    resource_group_name            = "dev-mono-pcsl-rg-01"
    address_space                  = ["10.0.0.0/16"]
    dns_servers                    = null
    # bgp_community                  = "12076:50017"
    # edge_zone                      = "mumbai-edge-zone-1"
    flow_timeout_in_minutes        = 10
    private_endpoint_vnet_policies = "Disabled"
    subnets = {
      subnet01 = {
        name             = "frontend_subnet1"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet02 = {
        name             = "baackend_subnet1"
        address_prefixes = ["10.0.2.0/24"]
      }
    }

    encryption = {
      enforcement = "AllowUnencrypted"
    }

    tags = {
      environment = "dev"
      owner       = "ParitoshPany"
      costcenter  = "delhi006"

    }
  }
}

#Define your AKS clusters below
#----------------------------------------------------------------------
#----------------------------------------------------------------------

aks-cluster = {

  aks1 = {
    name                = "myaksclustwa990"
    location            = "eastus"
    resource_group_name = "dev-micro-pcsl-rg-03"
    dns_prefix          = "myaks1"
    default_node_pool = [
      {
        name       = "default"
        node_count = 1
        vm_size    = "standard_b16as_v2"
      }
    ]
    identity = [{
      type = "SystemAssigned"
    }]
    tags = {
      Environment = "Production"
      owner       = "pcsl_pvt_ltd"

    }

  }
}
#Define public IP here 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
public_ips = {

  public_ip01 = {
    name                = "frontend_pip"
    resource_group_name = "dev-mono-pcsl-rg-01"
    location            = "centralindia"
    allocation_method   = "Static"

    tags = {
      env   = "Production"
      owner = "paritosh"
    }
  }
    public_ip02 = {
    name                = "backend_pip"
    resource_group_name = "dev-mono-pcsl-rg-01"
    location            = "centralindia"
    allocation_method   = "Static"

    tags = {
      env   = "Production"
      owner = "paritosh"
    }
  }
}





#Define your virtual machines & network interfaces below
#----------------------------------------------------------------------
#----------------------------------------------------------------------
virtual_machines = {
  vm01 = {
    nic_name            = "pcsl-vm-nic"
    location            = "centralindia"
    resource_group_name = "dev-mono-pcsl-rg-01"

    subnet_name = "frontend_subnet1"
    vnet_name   = "pcslmonovnet01"
    pip_name    = "frontend_pip" 

    ip_forwarding_enabled          = false
    accelerated_networking_enabled = false
    ip_configurations = {
      ip_config01 = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
      }
    }
    vm_name        = "vm-pcsl-frontend01"
    size           = "Standard_B2s"
  secret_name_un = "username"
    sec_name_pw = "password"
    kv_name = "todokeyvault99"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  vm02 = {
    nic_name            = "pcsl-vm-nic1"
    location            = "centralindia"
    resource_group_name = "dev-mono-pcsl-rg-01"

    subnet_name = "baackend_subnet1"
    vnet_name   = "pcslmonovnet01"
    pip_name    = "backend_pip" 

    ip_forwarding_enabled          = false
    accelerated_networking_enabled = false
    ip_configurations = {
      ip_config01 = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
      }
    }
    vm_name        = "vm-pcsl-backend01"
    size           = "Standard_B2s"
  secret_name_un = "username"
    sec_name_pw = "password"
    kv_name = "todokeyvault99"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

#Define your keyvaults here 
#----------------------------------------------------------------------
#----------------------------------------------------------------------
keyvaults = {
  keyvault1 = {
    name                        = "todokeyvault99"
    location                    = "centralindia"
    resource_group_name         = "dev-mono-pcsl-rg-01"
    enabled_for_disk_encryption = true

    soft_delete_retention_days = 7
    purge_protection_enabled   = false

    sku_name                        = "standard"
    enabled_for_deployment          = false
    enabled_for_template_deployment = false
    rbac_authorization_enabled      = false
    public_network_access_enabled   = true
    access_policy = {


      key_permissions = [
        "Get",
      ]

      secret_permissions = [
        "Get", "Set", "Delete", "List",
      ]

      storage_permissions = [
        "Get",
      ]
    }
  }

}



#define SQL servers here
#----------------------------------------------------------------------
#----------------------------------------------------------------------
mssqls = {
  sqlserver01 = {
    name                                 = "dev-mssqlserver-pcsl-01"
    resource_group_name                  = "dev-mono-pcsl-rg-01"
    location                             = "centralindia"
    version                              = "12.0"
    administrator_login                  = "azureuser"
    administrator_login_password         = "Hanuman@2025"
    minimum_tls_version                  = "1.2"
    public_network_access_enabled        = true
    outbound_network_restriction_enabled = false

    tags = {
      environment = "dev"
      owner       = "paritoshPany"
    }
  }
}
#define SQL database here
#----------------------------------------------------------------------
#----------------------------------------------------------------------
sqldbs = {
  sqldb1 = {
    name                = "mysbldatabasedev"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"
    mssqlserver_name    = "dev-mssqlserver-pcsl-01"
    resource_group_name = "dev-mono-pcsl-rg-01"
    tags = {
      environment = "dev"
      owner       = "Paritosh Pany"
    }
  }
}


#------------------------------------------------------------------------
#------------------------------------------------------------------------

acrs = {
  acr1 = {
    name                = "pcslacrregistry99"
    resource_group_name = "dev-mono-pcsl-rg-01"
    location            = "centralindia"
    sku                 = "Standard"

    # georeplications = {
    #   grs1 = {
    #     location                = "North Europe"
    #     zone_redundancy_enabled = true
    #     tags = {
    #       environment = "dev"
    #       owner       = "paritosh"
    #     }
    #   }
    # }
  }
}


#============================================================
#============================================================

secrets = {
  vmsecret01 = {
    kv_name = "todokeyvault99"
    resource_group_name = "dev-mono-pcsl-rg-01"
    secret_name = "username"
    secret_value = "adminuser"
  }

    vmsecret02 = {
    kv_name = "todokeyvault99"
    resource_group_name = "dev-mono-pcsl-rg-01"
    secret_name = "password"
    secret_value = "Hanuman@2025"
  }
}