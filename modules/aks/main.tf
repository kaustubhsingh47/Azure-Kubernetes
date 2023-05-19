resource "azurerm_kubernetes_cluster" "aks" {
    resource_group_name                     = "${var.resource_group_name}-${var.client_name}-${var.environment}"
    node_resource_group                     = "MC-${var.resource_group_name}-${var.client_name}-${var.environment}-by-Azure"
    kubernetes_version                      = var.kubernetes_master_version
    location                                = var.location
    name                                    = var.cluster_name
    sku_tier                                = var.sku_tier
    default_node_pool {
        enable_auto_scaling                 = var.enable_auto_scaling
        enable_host_encryption              = var.enable_host_encryption
        enable_node_public_ip               = var.enable_node_public_ip
        max_count                           = var.max_count
        max_pods                            = var.max_pods
        min_count                           = var.min_count
        name                                = var.node_pool_name
        node_labels                         = var.node_labels
        kubelet_disk_type                   = var.kubelet_disk_type
        node_taints                         = var.node_taints
        orchestrator_version                = var.kubernetes_node_version
        os_disk_size_gb                     = var.os_disk_size_gb
        os_disk_type                        = var.os_disk_type
        os_sku                              = var.os_sku_image
        tags                                = {
                    environment             = var.environment
                    client                  = var.client_name
        }
        type                                = var.node_pool_type
        ultra_ssd_enabled                   = var.ultra_ssd_enabled
        vm_size                             = var.node_pool_vm_size
        zones                               = var.node_pool_zones
    }
    local_account_disabled                  = var.local_account_disabled
    role_based_access_control_enabled       = var.role_based_access_control_enabled    
    identity {
        type                                = var.identity_type
     }
    azure_active_directory_role_based_access_control {
      managed                = true
      tenant_id              = "8587af23-dde8-4a87-a385-0d4080fa6df9"
      azure_rbac_enabled     = true
    }

#Networking

    network_profile {
        network_plugin                      = var.network_plugin
        outbound_type                       = var.outbound_type
        load_balancer_sku                   = var.load_balancer_sku
        network_policy                      = var.network_policy
    }

#Integration
    private_dns_zone_id                     = var.private_dns_zone_id
    dns_prefix                              = var.dns_prefix
    public_network_access_enabled           = var.public_network_access_enabled
    private_cluster_enabled                 = var.private_cluster_enabled
    private_cluster_public_fqdn_enabled     = var.private_cluster_public_fqdn_enabled
    azure_policy_enabled                    = var.azure_policy_enabled  


#Tags and timeout 
    tags                                    = {
                environment                 = var.environment
                client                      = var.client_name
        }
    timeouts {
        create  = "100m"
        update  = "100m"
    }
}
