/******************************************
  Common
******************************************/

variable "client_name" {
  type        = string
  description = "The name of the client associated with the infrastructure."
}

variable "environment" {
  type        = string
  description = "The name of the environment (e.g. 'dev', 'qa', 'prod')."
}

/******************************************
  resource group
******************************************/

variable "resource_group_name" {
  type        = string
  description = "The type of resource to create in Azure (e.g. 'aks/vms')."
}

variable "resource_group_location" {
  type        = string
  description = "The location where the resource group will be created in Azure (e.g. 'eastus')."
}


/******************************************
  AKS Basic
******************************************/

variable "cluster_resource_group" {
  description = "The name of the resource group that contains the Kubernetes cluster."
  type        = string
}

variable "node_resource_group" {
  description = "The name of the resource group that contains the Kubernetes nodes."
  type        = string
}
variable "kubernetes_master_version" {
  description = "The version of Kubernetes to use for the Kubernetes cluster."
  type        = string
}

variable "location" {
  description = "The location of the Kubernetes cluster."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier of the Kubernetes cluster."
  type        = string
}

/******************************************
  Node pools
******************************************/

variable "enable_auto_scaling" {
  type        = bool
  description = "Whether or not to enable auto scaling for the node pool"
}

variable "enable_host_encryption" {
  type        = bool
  description = "Whether or not to enable host encryption for the node pool"
}

variable "enable_node_public_ip" {
  type        = bool
  description = "Whether or not to enable a public IP for each node in the node pool"
}

variable "max_count" {
  type        = number
  description = "The maximum number of nodes allowed in the node pool"
}

variable "max_pods" {
  type        = number
  description = "The maximum number of pods that can run on each node in the node pool"
}

variable "min_count" {
  type        = number
  description = "The minimum number of nodes allowed in the node pool"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the node pool"
}

variable "node_labels" {
  type        = map(string)
  description = "A map of labels to apply to each node in the node pool"
}

variable "kubelet_disk_type" {
  type        = string
  default     = "OS"
  description = "The type of disk to use for the Kubelet on each node in the node pool (either 'OS' or 'Data')"
}

variable "node_taints" {
  type        = list(string)
  description = "List of taints to apply to each node in the node pool"
}

variable "kubernetes_node_version" {
  type        = string
  description = "The version of the orchestrator(node-pool) to use for the managed cluster"
}

# The size of the OS disk to use for each node in the node pool
variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk to use for each node in the node pool"
}

variable "os_disk_type" {
  type        = string
  description = "The type of OS disk to use for each node in the node pool (either 'Managed' or 'Ephemeral')"
}

variable "os_sku_image" {
  type        = string
  description = "The SKU of the OS image to use for each node in the node pool"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to each resource created by the module"
}

variable "node_pool_type" {
  type        = string
  description = "The type of the managed cluster (either 'VirtualMachineScaleSets' or 'AvailabilitySet')"
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = "Boolean value indicating whether or not UltraSSD is enabled for the managed cluster"
}

variable "node_pool_vm_size" {
  type        = string
  description = "The VM size to use for each node in the node pool"
}

variable "node_pool_zones" {
  type        = list(string)
  description = "The list of zones to spread the nodes across"
}

/******************************************
  ACCESS
******************************************/
variable "local_account_disabled" {
  description = "Specifies whether local account authentication is disabled for the Kubernetes cluster."
  type        = bool
}

variable "role_based_access_control_enabled" {
  description = "Specifies whether role-based access control (RBAC) is enabled for the Kubernetes cluster."
  type        = bool
}

variable "identity_type" {
  description = "The type of the managed identity to create."
  type        = string
}

/******************************************
  Networking
******************************************/
variable "network_plugin" {
  description = "The CNI plugin used for networking in the AKS cluster."
  type        = string
}

variable "outbound_type" {
  description = "The type of outbound connectivity for the AKS cluster."
  type        = string
}

variable "load_balancer_sku" {
  description = "The SKU of the load balancer associated with the AKS cluster."
  type        = string
  default     = "standard"
}

variable "network_policy" {
  description = "The network policy plugin used for network policy enforcement in the AKS cluster."
  type        = string
}


/******************************************
  Integration
******************************************/
variable "azure_policy_enabled" {
  description = "Specifies whether Azure Policy is enabled for the Kubernetes cluster."
  type        = bool
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone for the Kubernetes cluster."
  type        = string
}
variable "dns_prefix" {
  description = "The DNS prefix for the Kubernetes cluster."
  type        = string
}
variable "public_network_access_enabled" {
  description = "Specifies whether public network access is enabled for the Kubernetes cluster."
  type        = bool
}

variable "private_cluster_enabled" {
  description = "Specifies whether the Kubernetes cluster is private."
  type        = bool
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Specifies whether the Kubernetes cluster has a public fully qualified domain name (FQDN) enabled."
  type        = bool
}