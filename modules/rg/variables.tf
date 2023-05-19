variable "client_name" {
  type        = string
  description = "The name of the client associated with the infrastructure."
}

variable "environment" {
  type        = string
  description = "The name of the environment (e.g. 'dev', 'qa', 'prod')."
}

variable "resource_group_name" {
  type        = string
  description = "The type of resource to create in Azure (e.g. 'aks/vms')."
}

variable "resource_group_location" {
  type        = string
  description = "The location where the resource group will be created in Azure (e.g. 'eastus')."
}
