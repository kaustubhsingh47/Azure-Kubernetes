/******************************************
  Common
******************************************/
client_name                 = "bhashini"
environment                 = "dev"

/******************************************
  resource group
******************************************/
resource_group_name         = "rg"
resource_group_location     = "eastus"

/******************************************
  AKS Basic
******************************************/
cluster_resource_group         = "rg-cvs-poc"
node_resource_group            = "MC_rg-aks-cvs-prod_m-by-azure"
kubernetes_master_version      = "1.24.9"
location                       = "eastus"
cluster_name                   = "aks"
sku_tier                       = "Paid"

/******************************************
  Node pools
******************************************/
enable_auto_scaling             =    true
enable_host_encryption          =    false
enable_node_public_ip           =    false
max_count                       =    5
max_pods                        =    200
min_count                       =    1
node_pool_name                  =    "agentpool"
node_labels                     =    {}     # {key1 = "Value1", key2 = "value2"}
kubelet_disk_type               =    "OS"
node_taints                     =    []
kubernetes_node_version         =    "1.24.9"
os_disk_size_gb                 =    100
os_disk_type                    =    "Managed"
os_sku_image                    =    "Ubuntu"
node_pool_type                  =    "VirtualMachineScaleSets"
ultra_ssd_enabled               =    false
node_pool_vm_size               =    "Standard_DS2_v2"      #https://learn.microsoft.com/en-us/azure/virtual-machines/sizes
node_pool_zones                 =    ["1", "2", "3"]

/******************************************
  Access
******************************************/
local_account_disabled              = false
role_based_access_control_enabled   = true
identity_type                       = "SystemAssigned"

/******************************************
  Networking
******************************************/
network_plugin                      =   "kubenet"
outbound_type                       =   "loadBalancer"
load_balancer_sku                   =   "standard"
network_policy                      =   "calico"

/******************************************
  Integration
******************************************/
azure_policy_enabled                =   false
private_dns_zone_id                 =   "System"
dns_prefix                          =   "aks-cvs-prod-dns"
public_network_access_enabled       =   false
private_cluster_enabled             =   true
private_cluster_public_fqdn_enabled =   false


/******************************************
  Tags and timeout
******************************************/
tags                                =  {} #{key1 = "Value1", key2 = "value2"}
