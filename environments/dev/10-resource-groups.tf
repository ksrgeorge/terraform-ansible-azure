###############################
# Creation of Resource Groups #
###############################

# Creation of the resource group for dmz
resource "azurerm_resource_group" "app01" {
    name        = "app01"
    location    = "West Europe"
    tags {
        enviroment = "Development"
    }
}