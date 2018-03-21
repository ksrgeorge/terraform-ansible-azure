##################################
# Creation of Network Interfaces #
##################################

# Creation of the network interface for openvpn box
resource "azurerm_network_interface" "nic01-ovpn01" {
    name                = "nic01-ovpn01"
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.app01.name}"

    ip_configuration {
        name                          = "ip-nic01-ovpn01"
        subnet_id                     = "${azurerm_subnet.dmz-subnet01.id}"
        private_ip_address_allocation = "static"
        private_ip_address            = "10.20.1.3"
    }
}

# Creation of the network interface for jumpbox
resource "azurerm_network_interface" "nic01-jmpl01" {
    name                = "nic01-jmpl01"
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.app01.name}"

    ip_configuration {
        name                          = "ip-nic01-jmpl01"
        subnet_id                     = "${azurerm_subnet.dmz-subnet01.id}"
        private_ip_address_allocation = "static"
        private_ip_address            = "10.20.1.4"
    }
}