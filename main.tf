##############################
# Terraform Ansible Template #
##############################

# Creation of the resource group
resource "azurerm_resource_group" "production" {
    name        = "terraform-ansible-template"
    location    = "West Europe"
}

# Creation of the VNET
resource "azurerm_virtual_network" "production" {
    name                = "vnetprd"
    address_space       = ["10.0.0.0/16"]
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.production.name}"
}

# Creation of the subnet
resource "azurerm_subnet" "production" {
    name                 = "subnetprd"
    resource_group_name  = "${azurerm_resource_group.production.name}"
    virtual_network_name = "${azurerm_virtual_network.production.name}"
    address_prefix       = "10.0.2.0/24"
}

# Creation of the network interface
resource "azurerm_network_interface" "production" {
    name                = "networkintprd"
    location            = "West Europe"
    resource_group_name = "${azurerm_resource_group.production.name}"

    ip_configuration {
        name                          = "ipconfprd"
        subnet_id                     = "${azurerm_subnet.production.id}"
        private_ip_address_allocation = "static"
        private_ip_address            = "10.0.2.4"
    }
}

# Creation of managed Disk
resource "azurerm_managed_disk" "production" {
    name                 = "data-managed-disk-prd"
    location             = "West Europe"
    resource_group_name  = "${azurerm_resource_group.production.name}"
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "1023"
}

# Creation of Virtual Machine
resource "azurerm_virtual_machine" "production" {
    name                  = "machineprd"
    location              = "West Europe"
    resource_group_name   = "${azurerm_resource_group.production.name}"
    network_interface_ids = ["${azurerm_network_interface.production.id}"]
    vm_size               = "Standard_DS1_v2"

    # Uncomment this line to delete the OS disk automatically when deleting the VM
    delete_os_disk_on_termination = true

    # Uncomment this line to delete the data disks automatically when deleting the VM
    delete_data_disks_on_termination = true
    # Ubuntu Image
    storage_image_reference {
        publisher  = "Canonical"
        offer      = "UbuntuServer"
        sku        = "16.04-LTS"
        version    = "latest"
    }
    # OS Disk
    storage_os_disk {
        name              = "diskosprd"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    # OS Profile
    os_profile {
        computer_name  = "prodmachine"
        admin_username = "ksrgeorge"
        admin_password = "Ksrgeorge_1"
    }
    # Linux config
    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "demo"
    }
}