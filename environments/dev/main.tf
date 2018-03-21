##############################
# Terraform Ansible Template #
##############################

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

# Creation of the VNET
resource "azurerm_virtual_network" "vnet-app01" {
    name                = "vnet-app01"
    address_space       = ["10.20.0.0/16"]
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.vnets.name}"
}

##################################
# Creation of Subnets #
##################################

# Creation of the 1st subnet of the dmz
resource "azurerm_subnet" "dmz-subnet01" {
    name                 = "dmz-subnet01"
    resource_group_name  = "${azurerm_resource_group.subnets.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.1.0/24"
}

# Creation of the 2st subnet of the webservers
resource "azurerm_subnet" "webservers-subnet01" {
    name                 = "webservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.subnets.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.2.0/24"
}

# Creation of the 3rd subnet of the appservers
resource "azurerm_subnet" "appservers-subnet01" {
    name                 = "appservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.subnets.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.3.0/24"
}

# Creation of the 4th subnet of the dataservers
resource "azurerm_subnet" "dataservers-subnet01" {
    name                 = "dataservers-subnet01"
    resource_group_name  = "${azurerm_resource_group.subnets.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.4.0/24"
}

# Creation of the 5th subnet for management
resource "azurerm_subnet" "management-subnet01" {
    name                 = "management-subnet01"
    resource_group_name  = "${azurerm_resource_group.subnets.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet-app01.name}"
    address_prefix       = "10.20.5.0/24"
}


# Creation of the 1st pair of network interfaces for the Webservers
// resource "azurerm_network_interface" "nic01-webservers01" {
//     name                = "nic01-webservers01"
//     location            = "West Europe"
//     resource_group_name = "${azurerm_resource_group.production.name}"

//     ip_configuration {
//         name                          = "ip-nic01-webservers01"
//         subnet_id                     = "${azurerm_subnet.webservers-subnet01.id}"
//         private_ip_address_allocation = "static"
//         private_ip_address            = "10.20.1.3"
//     }
// }

// resource "azurerm_network_interface" "production" {
//     name                = "nic01-webservers02"
//     location            = "West Europe"
//     resource_group_name = "${azurerm_resource_group.production.name}"

//     ip_configuration {
//         name                          = "ip-nic01-webservers02"
//         subnet_id                     = "${azurerm_subnet.production.id}"
//         private_ip_address_allocation = "static"
//         private_ip_address            = "10.20.1.4"
//     }
// }

// # Creation of the 2nd pair of network interfaces for the Webservers
// resource "azurerm_network_interface" "production" {
//     name                = "nic02-webservers01"
//     location            = "West Europe"
//     resource_group_name = "${azurerm_resource_group.production.name}"

//     ip_configuration {
//         name                          = "ip-nic02-webservers01"
//         subnet_id                     = "${azurerm_subnet.production.id}"
//         private_ip_address_allocation = "static"
//         private_ip_address            = "10.20.2.3"
//     }
// }

// resource "azurerm_network_interface" "production" {
//     name                = "nic02-webservers02"
//     location            = "West Europe"
//     resource_group_name = "${azurerm_resource_group.production.name}"

//     ip_configuration {
//         name                          = "ip-nic02-webservers02"
//         subnet_id                     = "${azurerm_subnet.production.id}"
//         private_ip_address_allocation = "static"
//         private_ip_address            = "10.20.2.4"
//     }
// }

// #############################
// # Creation of managed Disks #
// #############################

// # Creation of the 1st webserver managed disk
// resource "azurerm_managed_disk" "production" {
//     name                 = "data-managed-disk-web01"
//     location             = "West Europe"
//     resource_group_name  = "${azurerm_resource_group.production.name}"
//     storage_account_type = "Standard_LRS"
//     create_option        = "Empty"
//     disk_size_gb         = "1023"
// }

// # Creation of the 2nd webserver managed disk
// resource "azurerm_managed_disk" "production" {
//     name                 = "data-managed-disk-web02"
//     location             = "West Europe"
//     resource_group_name  = "${azurerm_resource_group.production.name}"
//     storage_account_type = "Standard_LRS"
//     create_option        = "Empty"
//     disk_size_gb         = "1023"
// }

// ################################
// # Creation of Virtual Machines #
// ################################

// # Creation of the first webserver
// resource "azurerm_virtual_machine" "production" {
//     name                  = "webserver01"
//     location              = "West Europe"
//     resource_group_name   = "${azurerm_resource_group.production.name}"
//     network_interface_ids = ["${azurerm_network_interface.production.id}"]
//     vm_size               = "Standard_DS1_v2"

//     # Uncomment this line to delete the OS disk automatically when deleting the VM
//     delete_os_disk_on_termination = true

//     # Uncomment this line to delete the data disks automatically when deleting the VM
//     delete_data_disks_on_termination = true
//     # Ubuntu Image
//     storage_image_reference {
//         publisher  = "Canonical"
//         offer      = "UbuntuServer"
//         sku        = "16.04-LTS"
//         version    = "latest"
//     }
//     # OS Disk
//     storage_os_disk {
//         name              = "diskosweb01"
//         caching           = "ReadWrite"
//         create_option     = "FromImage"
//         managed_disk_type = "Standard_LRS"
//     }
//     # OS Profile
//     os_profile {
//         computer_name  = "webserver01"
//         admin_username = "ksrgeorge"
//         admin_password = "Ksrgeorge_1"
//     }
//     # Linux config
//     os_profile_linux_config {
//         disable_password_authentication = false
//     }

//     tags {
//         environment = "production"
//     }
// }

// # Creation of the second webserver
// resource "azurerm_virtual_machine" "production" {
//     name                  = "webserver02"
//     location              = "West Europe"
//     resource_group_name   = "${azurerm_resource_group.production.name}"
//     network_interface_ids = ["${azurerm_network_interface.production.id}"]
//     vm_size               = "Standard_DS1_v2"

//     # Uncomment this line to delete the OS disk automatically when deleting the VM
//     delete_os_disk_on_termination = true

//     # Uncomment this line to delete the data disks automatically when deleting the VM
//     delete_data_disks_on_termination = true
//     # Ubuntu Image
//     storage_image_reference {
//         publisher  = "Canonical"
//         offer      = "UbuntuServer"
//         sku        = "16.04-LTS"
//         version    = "latest"
//     }
//     # OS Disk
//     storage_os_disk {
//         name              = "diskosweb02"
//         caching           = "ReadWrite"
//         create_option     = "FromImage"
//         managed_disk_type = "Standard_LRS"
//     }
//     # OS Profile
//     os_profile {
//         computer_name  = "webserver02"
//         admin_username = "ksrgeorge"
//         admin_password = "Ksrgeorge_1"
//     }
//     # Linux config
//     os_profile_linux_config {
//         disable_password_authentication = false
//     }

//     tags {
//         environment = "production"
//     }
// }