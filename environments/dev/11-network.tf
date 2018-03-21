##############################
# Terraform Network #
##############################

# Creation of the VNET
resource "azurerm_virtual_network" "vnet-app01" {
    name                = "vnet-app01"
    address_space       = ["10.20.0.0/16"]
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.app01.name}"
}

##################################
# Creation of Subnets #
##################################

# Creation of the 1st subnet of the dmz
resource "azurerm_subnet" "dmz-subnet01" {
    name                 = "dmz-subnet01"
    resource_group_name  = "${azurerm_resource_group.app01.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.1.0/24"
}

# Creation of the 2st subnet of the webservers
resource "azurerm_subnet" "webservers-subnet01" {
    name                 = "webservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.app01.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.2.0/24"
}

# Creation of the 3rd subnet of the appservers
resource "azurerm_subnet" "appservers-subnet01" {
    name                 = "appservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.app01.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.3.0/24"
}

# Creation of the 4th subnet of the dataservers
resource "azurerm_subnet" "dataservers-subnet01" {
    name                 = "dataservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.app01.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.4.0/24"
}

# Creation of the 5th subnet for management
resource "azurerm_subnet" "management-subnet01" {
    name                 = "management-subnet01"
    resource_group_name  = "${azurerm_resource_group.app01.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.5.0/24"
}