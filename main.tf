resource "azurerm_resource_group" "useast-ext-rg" {
  #
  name     = "useast-ext-rg"
  location = var.location
  tags = {
    application = "waf"
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "ext-vnet" {
  name                = var.ext-vnet.name
  resource_group_name = azurerm_resource_group.useast-ext-rg.name
  location            = var.location
  address_space       = var.ext-vnet.prefix
  tags                = azurerm_resource_group.useast-ext-rg.tags
}

resource "azurerm_subnet" "extappgw-subnet" {
  name                 = var.extappgw.name
  address_prefixes     = var.extappgw.prefix
  resource_group_name  = azurerm_resource_group.useast-ext-rg.name
  virtual_network_name = azurerm_virtual_network.ext-vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}

resource "azurerm_subnet" "ext-integration-subnet" {
  name                 = var.ext-integration.name
  address_prefixes     = var.ext-integration.prefix
  resource_group_name  = azurerm_resource_group.useast-ext-rg.name
  virtual_network_name = azurerm_virtual_network.ext-vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "extweb-subnet" {
  name                 = var.extweb.name
  address_prefixes     = var.extweb.prefix
  resource_group_name  = azurerm_resource_group.useast-ext-rg.name
  virtual_network_name = azurerm_virtual_network.ext-vnet.name
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
}