resource "azurerm_resource_group" "az_rg" {
  name                      = "${var.resource_group_name}-${var.client_name}-${var.environment}"
  location                  = var.resource_group_location
  tags                      = {
      environment           = var.environment
      client                = var.client_name
  }
}