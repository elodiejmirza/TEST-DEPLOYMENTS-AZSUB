terraform {

  cloud {
    organization = "SoloSentry"

    workspaces {
      name = "TEST-DEPLOYMENTS-AZSUB-CLI-REMOTE-EXEC"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.88.1"
    }
  }
}

provider "azurerm" {
  features {}
}