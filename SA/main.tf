
resource "azurerm_resource_group" "rg" {
  name     = "moghrg"
  location = "East US"
}

resource "azurerm_storage_account" "sa1" {
  name                     = "samogh"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
}

# Define the Blob Storage queue
resource "azurerm_storage_queue" "queue" {
  name                  = "queuemogh"
  storage_account_name  = azurerm_storage_account.sa1.name
  queue_length          = 1000
  message_ttl           = "PT1H" # 1 hour
  visibility_timeout    = "PT30S" # 30 seconds
}

# Define the diagnostic settings for the storage account
resource "azurerm_diagnostic_settings" "diag" {
  name               = "example-diag-settings"
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

      # Define the Blob Storage target where the diagnostic logs will be stored
      target_blob {
        name        = "loga-mogh"
        container   = azurerm_storage_container.example.name
        type        = "Diagnostics"
      }
    }
  }
}

# Define the Blob Storage container for diagnostic logs
resource "azurerm_storage_container" "example" {
  name                  = "diagcontainer"
  storage_account_name  = azurerm_storage_account.sa1.name
  container_access_type = "private"
}

