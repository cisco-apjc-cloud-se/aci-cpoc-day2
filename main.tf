terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "mel-ciscolabs-com"
    workspaces {
      name = "aci-cpoc-day2"
    }
  }
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      # version = "~> 0.5.1"
    }
  }
}

### Shared Providers ###

provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}

## ACI Networking Module
module "aci_tenants" {
  # source = "./modules/aci"
  source = "github.com/cisco-apjc-cloud-se/terraform-aci-day2"

  ### Tenants ###
  tenants   = var.tenants

}
