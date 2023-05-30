resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_management_lock" "resource-group-level" {
  name       = var.lock_name
  scope      = azurerm_resource_group.example.id
  lock_level = var.lock_level
  notes      = var.notes
}
