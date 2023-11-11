resource "azurerm_resource_group" "rg-uks-test-mssql-001" {
  name     = "rg-uks-test-mssql-001"
  location = "uksouth"
}
/*
resource "azurerm_storage_account" "example" {
  name                     = "examplesa"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}*/

resource "azurerm_mssql_server" "sql-uks-test-mssql-001" {
  name                         = "sql-uks-test-mssql-001"
  resource_group_name          = azurerm_resource_group.rg-uks-test-mssql-001.name
  location                     = azurerm_resource_group.rg-uks-test-mssql-001.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "sqldb-uks-test-mssql-001" {
  name           = "sqldb-uks-test-mssql-001"
  server_id      = azurerm_mssql_server.sql-uks-test-mssql-001.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

  tags = {
    foo = "bar"
  }
}