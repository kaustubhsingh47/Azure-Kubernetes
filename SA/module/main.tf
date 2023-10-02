

# Define the resource group and storage account
resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa1" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only
}

# Define the Blob Storage, File Storage, Queue Storage, and Table Storage services
resource "azurerm_storage_blob_service" "blob" {
  storage_account_name = azurerm_storage_account.sa1.name
  name                 = var.blob_name
  enabled              = true
}

resource "azurerm_storage_file_service" "file" {
  storage_account_name = azurerm_storage_account.sa1.name
  name                 = var.file_name
  enabled              = true
}

resource "azurerm_storage_queue_service" "queue" {
  storage_account_name = azurerm_storage_account.sa1.name
  name                 = var.queue_name
  enabled              = true
}

resource "azurerm_storage_table_service" "table" {
  storage_account_name = azurerm_storage_account.sa1.name
  name                 = var.table_name
  enabled              = true
}

# Define the private endpoint
resource "azurerm_private_endpoint" "endpoint" {
  name                = var.private_endpoint_name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  subnet_id           = azurerm_subnet.example.id
  private_service_connection {
    name                           = var.service_connection_name
    private_connection_resource_id = azurerm_storage_account.sa1.id
    subresource_names              = [
      "blob",
      "queue",
      "file",
      "table",
    ]
    is_manual_connection = false
  }
}

# Define the subnet where the private endpoint will be placed
resource "azurerm_subnet" "sub1" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = var.address_prefixes
}

# Define the virtual network where the private endpoint subnet will be created
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

# Define the diagnostic settings for the storage account services
resource "azurerm_diagnostic_settings" "diag" {
  name               = var.diag_name
  target_resource_id = azurerm_storage_account.sa1.id

  log {
    category = "StorageRead"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "StorageWrite"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "QueueServiceMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "QueueServiceLogging"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "QueueServiceDiagnostics"
    enabled  = true

    retention_policy {
      enabled = false
    }

    blob_storage {
      days    = 30
      enabled = true

      target_blob {
        name        = var.target_blob
        container   = azurerm_storage_container.cont1.name
        type        = var.target_type
        path_format = var.path_format
      }
    }
  }
}

# Define the Blob Storage container for diagnostic logs
resource "azurerm_storage_container" "cont1" {
  name                  = var.cont_name
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = var.container_access_type
}


