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

# ## ACI Networking Module
# module "aci_tenants" {
#   # source = "./modules/aci"
#   source = "github.com/cisco-apjc-cloud-se/terraform-aci-day2"
#
#   ### Tenants ###
#   tenants   = var.tenants
#
# }

/*
NOTE:
- Need to add inter-VRF route leaking - not currently supported by Terraform
*/

### ACI Tenant Object Module ###
module "cpoc_common_tenant" {
  source = "github.com/cisco-apjc-cloud-se/terraform-aci-tenant-object"

  ### Tenant ###
  tenant   = var.common_tenant

}

# ### ACI Tenant Object Module ###
# module "cpoc_demo_tenant" {
#   source = "github.com/cisco-apjc-cloud-se/terraform-aci-tenant-object"
#
#   ### Tenant ###
#   tenant   = var.demo_tenant
#
}
