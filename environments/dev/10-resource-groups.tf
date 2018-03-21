# Creation of the resource group for vnets
resource "azurerm_resource_group" "vnets" {
    name        = "vnets"
    location    = "West Europe"
    tags {
        enviroment = "Development"
    }
}

# Creation of the resource group for subnets
resource "azurerm_resource_group" "subnets" {
    name        = "subnets"
    location    = "West Europe"
    tags {
        enviroment = "Development"
    }
}
