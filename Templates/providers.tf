terraform {

  cloud {
    organization = "SoloSentry"

    workspaces {
      //name = "TEST-DEPLOYMENTS-AZSUB-CLI-REMOTE-EXEC"
      name = "TEST-DEPLOYMENTS-AZSUB-CLI-REMOTE-EXEC-OIDC"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      //version = "~> 2.88.1"
      version = "3.79.0"
    }
  }
}

provider "azurerm" {
  features {}
}

