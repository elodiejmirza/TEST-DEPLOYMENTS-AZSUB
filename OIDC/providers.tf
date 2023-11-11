terraform {
  required_version = ">=0.12"
//}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
// Ensure the code block for TF Cloud is present and uncommented to use remote backend execution - NOT required for VCS driven workflow.
// See: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-vcs-change
// Also ensure the correct workspace is specified
terraform {
  cloud {
    organization = "SoloSentry"

    workspaces {
      name = "TEST-DEPLOYMENTS-AZSUB-CLI-REMOTE-EXEC-VCS-LINKED-OIDC"
      //name = "TEST-DEPLOYMENTS-AZSUB-CLI-REMOTE-EXEC-OIDC"
    }
  }
}

provider "azurerm" {
  features {}
}