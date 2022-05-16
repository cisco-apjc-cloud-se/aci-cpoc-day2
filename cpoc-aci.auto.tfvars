### Existing VMM Domain Name ###
vmm_name = "CPOC-SE-VC-HX"

### Existing Physical Domain Name ###
phys_name = "phys"

### Tenants ###
tenants = {
  tf-aci-cpoc = {
    name = "tf-aci-cpoc"
    description = "Demo ACI Tenant built from Terraform Cloud. Do not delete"
  }
}

### VRFs ###
vrfs = {
  external = {
    vrf_name    = "external"
    description = "External VRF for Demo ACI Tenant.  Not expected to be used."
    tenant_name = "tf-aci-cpoc" ## Tenant to add VRF to
    preferred_group = "disabled"
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  ext-85 = {
    bd_name     = "ext-85"
    vrf_name    = "external"      ## VRF to add BD to
    description = " Bridge Domain for External DMZ VLAN 85 in Demo ACI Tenant"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add VRF to
    mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
    arp_flood   = "yes" ## "yes", "no"
    l3outs      = [] ## List of associated L3outs for BD's Subnets
    subnets = {}
  }
}

### Application Profiles & End Point Groups ###
aps = {
  external = {
    ap_name = "external"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
    description = "App Profile for External DMZ VLANs"
    esgs = {}
    epgs = {
      internet-vl85 = {
        epg_name = "internet-85"
        bd_name = "ext-85"       ## Bridge Domain to add EPG to
        description = "EPG for External DMZ VLAN 85 in Demo ACI Tenant"
        vmm_enabled = true
        mapped_esg = ""
        preferred_group = "exclude"
        paths = {
          path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
            pod       = 1
            leaf_node = 101
            port      = "eth1/46"
            vlan_id   = 85
            mode      = "regular" # regular, native, untagged
          }
        }
      }
    }
  }
}

### Filters ###
filters = {}


### Contracts ###
contracts = {}

### L3Outs & External EPGs ###
l3outs = {}
