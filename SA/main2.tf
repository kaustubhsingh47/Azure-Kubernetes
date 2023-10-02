

# Define the resource group and storage account
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
}

# Define the Blob Storage, File Storage, Queue Storage, and Table Storage services
resource "azurerm_storage_blob_service" "example" {
  storage_account_name = azurerm_storage_account.example.name
  name                 = "blob"
  enabled              = true
}

resource "azurerm_storage_file_service" "example" {
  storage_account_name = azurerm_storage_account.example.name
  name                 = "file"
  enabled              = true
}

resource "azurerm_storage_queue_service" "example" {
  storage_account_name = azurerm_storage_account.example.name
  name                 = "queue"
  enabled              = true
}

resource "azurerm_storage_table_service" "example" {
  storage_account_name = azurerm_storage_account.example.name
  name                 = "table"
  enabled              = true
}

# Define the private endpoint
resource "azurerm_private_endpoint" "example" {
  name                = "example-private-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id
  private_service_connection {
    name                           = "example-connection"
    private_connection_resource_id = azurerm_storage_account.example.id
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
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Define the virtual network where the private endpoint subnet will be created
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Define the diagnostic settings for the storage account services
resource "azurerm_diagnostic_settings" "example" {
  name               = "example-diag-settings"
  target_resource_id = azurerm_storage_account.example.id

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
        name        = "example-diag-logs"
        container   = azurerm_storage_container.example.name
        type        = "Diagnostics"
        path_format = "{Year}/{Month}/{Day}/{Hour}/{Minute}"
      }
    }
  }
}

# Define the Blob Storage container for diagnostic logs
resource "azurerm_storage_container" "example" {
  name                  = "diagcontainer"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}


