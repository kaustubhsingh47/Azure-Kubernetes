# Define variables
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "account_tier" {
  description = "Storage Account tier (Standard or Premium)"
  type        = string
}

variable "account_replication_type" {
  description = "Storage Account replication type (LRS, GRS, ZRS, etc.)"
  type        = string
}

variable "enable_https_traffic_only" {
  description = "Enable HTTPS traffic only for the Storage Account"
  type        = bool
}

variable "blob_name" {
  description = "Name of the Blob Storage service"
  type        = string
}

variable "file_name" {
  description = "Name of the File Storage service"
  type        = string
}

variable "queue_name" {
  description = "Name of the Queue Storage service"
  type        = string
}

variable "table_name" {
  description = "Name of the Table Storage service"
  type        = string
}

variable "private_endpoint_name" {
  description = "Name of the Azure Private Endpoint"
  type        = string
}

variable "subnet_name" {
  description = "Name of the Azure Subnet for the Private Endpoint"
  type        = string
}

variable "vnet1_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network subnet"
  type        = list(string) 
}


variable "address_prefixes" {
  description = "Address prefixes for the Virtual Network subnet"
  type        = list(string) 
}

variable "diag_name" {
  description = "Name of the Diagnostic Settings for the Storage Account"
  type        = string
}

variable "target_blob" {
  description = "Name of the target Blob for diagnostic logs"
  type        = string
}

variable "target_type" {
  description = "Type of the target for diagnostic logs (Blob, Table, Queue, File)"
  type        = string
}

variable "path_format" {
  description = "Path format for the diagnostic logs"
  type        = string
}

variable "cont_name" {
  description = "Name of the Storage Container for diagnostic logs"
  type        = string
}

variable "container_access_type" {
  description = "Access type for the Storage Container (private, blob, container, or anonymous)"
  type        = string
}

variable "service_connection_name" {
    description = "Name of service connection"
    type        = string
}
