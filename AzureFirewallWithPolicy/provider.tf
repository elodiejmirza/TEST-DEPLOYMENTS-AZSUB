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
      version = "~>3.0"
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