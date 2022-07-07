### ACI Credentials & Users - from TFC Variable Set ###
variable "aci_user" {
}

variable "aci_password" {
}

variable "aci_url" {
}

# ### Existing ACI Virtual Machine Manager (VMM) Domain ###
# variable "vmm_name" {
#   type = string
# }
#
# ### Existing Physical Domain for Static EPGs ###
# variable "phys_name" {
#   type = string
# }

### Tennant Input Variable Object ###
variable "tenants" {}
