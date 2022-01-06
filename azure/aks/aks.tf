resource "azurerm_resource_group" "aks-rg" {
  name     = var.az_resource_group
  location = var.region
}

module "network" {
  source                = "Azure/network/azurerm"
  resource_group_name   = azurerm_resource_group.aks-rg.name
  address_spaces        = var.address_spaces
  subnet_prefixes       = var.subnet_prefixes
  subnet_names          = var.subnet_names
  depends_on            = [azurerm_resource_group.aks-rg]
}

data "azuread_group" "aks_group" {
  display_name = "aks-group"
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.aks-rg.name
  kubernetes_version               = "1.19.11"
  orchestrator_version             = "1.19.11"
  prefix                           = "lab"
  cluster_name                     = "my-aks"
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = 50
  sku_tier                         = "Paid" 
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  agents_min_count                 = 1
  agents_max_count                 = 2
  agents_count                     = null
  agents_max_pods                  = 100
  agents_pool_name                 = "poolnodes1"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "poolnodes1" : "defaultnodepool"
  }
  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = var.kube_dns_ip
  net_profile_docker_bridge_cidr = var.docker_bridge_ip
  net_profile_service_cidr       = var.k8s_service_cidr

  depends_on = [module.network]
}
