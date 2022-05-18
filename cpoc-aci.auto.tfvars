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
  internal = {
    vrf_name    = "internal"
    description = "Internal VRF for Demo ACI Tenant.  Preferred Group enabled."
    tenant_name = "tf-aci-cpoc" ## Tenant to add VRF to
    preferred_group = "enabled"
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  ext-85 = {
    bd_name     = "ext-85"
    vrf_name    = "external"      ## VRF to add BD to
    description = " Bridge Domain for External VLAN 85 in Demo ACI Tenant"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add VRF to
    mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
    arp_flood   = "yes" ## "yes", "no"
    l3outs      = [] ## List of associated L3outs for BD's Subnets
    subnets = {}
  }
  dmz = {
    bd_name     = "dmz"
    vrf_name    = "internal"      ## VRF to add BD to
    description = " Bridge Domain for Demo DMZ in Demo ACI Tenant"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add VRF to
    mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
    arp_flood   = "yes" ## "yes", "no"
    l3outs      = [] ## List of associated L3outs for BD's Subnets
    subnets = {
      sub-1 = {
        ip          = "100.64.64.17/28"
        description = "Primary Subnet for DMZ BD"
        scope       = ["public"]
        preferred   = "yes"
      }
    }
  }
}

### Application Profiles & End Point Groups ###
aps = {
  external = {
    ap_name = "external"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
    description = "App Profile for External VLANs"
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
  dmz = {
    ap_name = "dmz"
    tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
    description = "App Profile for DMZ VLANs"
    esgs = {}
    epgs = {
      iks-1 = {
        epg_name = "iks-1"
        bd_name = "dmz"       ## Bridge Domain to add EPG to
        description = "EPG for DMZ IKS Cluster #1 in Demo ACI Tenant"
        vmm_enabled = true
        mapped_esg = ""
        preferred_group = "exclude"
        paths = {}
      }
    }
  }
}

### Filters ###
filters = {}


### Contracts ###
contracts = {}

### L3Outs & External EPGs ###
l3outs = {
  ### STAGE 2 - Enable L3Out with OSPF & External EPG (RFC1918)
  dmz-firewall = {
    l3out_name      = "dmz-firewall"
    description     = "DMZ FTDv Firewall L3Out built from Terraform"
    tenant_name     = "tf-aci-cpoc"    ## Tenant to add filter to
    vrf_name        = "internal"
    l3_domain       = "dmz-firewall"
    ospf_profiles   = {
      ospf-1 = {
        description = "OSPF Peering to DMZ FTDv Firewall"
        area_cost   = 0
        area_id     = "0.0.0.0"
        area_type   = "regular"
      }
    }
    logical_profiles = {
      lprof-1 = {
        lprof_name  = "dmz-firewall"
        description = "DMZ FTDv Firewall Logical Profile created from Terraform"
        nodes = {
          node-1 = {
            pod = 1
            leaf_node = 101
            loopback_ip = "101.1.1.1"
          }
          node-2 = {
            pod = 1
            leaf_node = 102
            loopback_ip = "102.1.1.1"
          }
        }
        interface_profiles = {
          intprof-1 = {
            intprof_name  = "dmz-firewall"
            description   = "DMZ Firewall Interface Profile created from Terraform"
            ospf_profiles = {
              ospf-1 = {
                description = "OSPF Interface Auth and Policy Config"
                auth_key    = "key"
                auth_key_id = 255
                auth_type   = "none"
                # ospf_policy = "default"
              }
            }
            paths = {}
          }
        }
      }
    }
    extepgs = {
      cpoc-internet = {
        extepg_name         = "cpoc-internet"
        description         = "Public Internet from Sydney CPOC"
        preferred_group     = "exclude"
        consumed_contracts = {}
        provided_contracts = {}
        contract_master_epgs = {}
        subnets = {
          N-0-0-0-0-0 = {
            description = "0.0.0.0/0"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "0.0.0.0/0"
            scope = ["import-security"]
          }
        }
      }
    }
  }
}
