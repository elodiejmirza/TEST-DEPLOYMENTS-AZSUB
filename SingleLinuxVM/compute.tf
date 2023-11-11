
variable "adminuser_ssh_pubkey" {
  type = string
  description = "Public SSH key for adminuser account"
#[SuppressMessage("Microsoft.Security", "CS002:SecretInNextLine", Justification="The secrest is an SSH public key")]
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpHSKdPaQZTjgXkViWQ0pf24PgDf2dZXn4XHXCjrv8mAQ+TWPDzp/dQJ4I77nRgx46CJTkWiBfPE+rWCfiPHh5obyUS39w3jUtcwvDtckGRStC485F1ey38LawZmpHbbDZSzOgVYkrYhAleoH4tlZ3SLZGXG500IHsRriLjyu49ZShN9lKCO9Om7h+9jCMjM27jPlYdPk9zTIc1Or4aSwrD5qlsKcuduXo2fQCFd1JEHqBsZEpOBf4rnQlsjPwNAVsLG3Twnuok1/X0KNGqLWfF0/pzbYecnKU4LRlTfLaxMMJIR7zK1yaySRElDURPnL3UuMXHUxom4iMQucBVuD3Vj+zL2P0qzGEUj8dusfe4SgS/6RlPEfarG4E2nDfnfDVq3U5+8yizlcfGzFH6D23SXJHax9HcKsBLX77ralC8jwVdP8n8zO/uSUEcd5MALNyngHZEKdzZgG92r+O3fSU523TFrbbcC4SBoMYh+vb2N3ct4USabA1xdX3C6ZdoAa03B2vFRCT3xTY5EW6PB/MiCsVpoxwuM1KFHJu3nAOjvZ9Cz0NRQUO7ilTgrmJ0jAHShMkdSF7pqf97sRLm93pNbxI0YfaVCwsFS7w9U3qhCTOwFaTG5TaJA+ASB3FgS9vknqHVuiB1NUVqW+5pEVdNKnqwU8niD75LDI5Db6mDw== elodiemirza@Frightspear.local"
}

resource "azurerm_resource_group" "rg-lnxvm-uksouth-001" {
  name     = "rg-lnxvm-uksouth-001"
  location = "uksouth"
}

resource "azurerm_linux_virtual_machine" "lnxvm-uksouth-001" {
  name                = "lnxvm-uksouth-001"
  resource_group_name = azurerm_resource_group.rg-lnxvm-uksouth-001.name
  location            = azurerm_resource_group.rg-lnxvm-uksouth-001.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-lnxvm-uksouth-001.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.adminuser_ssh_pubkey   //file("./adminuser.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    //offer     = "0001-com-ubuntu-server-focal"
    //sku       = "20_04-lts"
    offer     = "0001-com-ubuntu-server-lunar"
    sku       = "23_04-gen2"
    version   = "latest"
  }
  identity {
    type = "SystemAssigned"
  }
}

