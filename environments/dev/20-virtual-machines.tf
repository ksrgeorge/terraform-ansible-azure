################################
# Creation of Virtual Machines #
################################

# Creation of the OpenVPN box
resource "azurerm_virtual_machine" "vpn01" {
    name                  = "openvpn01"
    location              = "West Europe"
    resource_group_name   = "${azurerm_resource_group.app01.name}"
    network_interface_ids = ["${azurerm_network_interface.nic01-ovpn01.id}"]
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
        name              = "disk-os-vpn01"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    # OS Profile
    os_profile {
        computer_name  = "openvpn01"
        admin_username = "${var.ssh_admin_username}"
        admin_password = "${var.ssh_admin_password}"
    }
    # Linux config
    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "Developement"
    }
}

# Creation of the Jumpbox
resource "azurerm_virtual_machine" "jmpl01" {
    name                  = "jmpl01"
    location              = "West Europe"
    resource_group_name   = "${azurerm_resource_group.app01.name}"
    network_interface_ids = ["${azurerm_network_interface.nic01-jmpl01.id}"]
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
        name              = "disk-os-jmpl01"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    # OS Profile
    os_profile {
        computer_name  = "jmpl01"
        admin_username = "${var.ssh_admin_username}"
        admin_password = "${var.ssh_admin_password}"
    }
    # Linux config
    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "Developement"
    }
}