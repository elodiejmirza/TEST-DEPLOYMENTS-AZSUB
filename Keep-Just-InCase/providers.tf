terraform {
  required_version = ">=0.12"

  cloud {
    organization = "SoloSentry"

    workspaces {
      name = "TEST-DEPLOYMENTS-AZSUB"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
