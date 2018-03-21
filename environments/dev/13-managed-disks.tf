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
