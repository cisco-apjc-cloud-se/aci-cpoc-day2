### Common Tenant Configuration ###
common_tenant = {
  name = "common"
  use_existing = true
  aps = {}
  networking = {
    vrfs = {
      cpoc = {
        vrf_name    = "cpoc"
        description = "Common VRF for routed access to main CPOC ACI fabric"
        preferred_group = "disabled"
      }
    }
    bds = {}
    l3outs = {
      cpoc-aci = {
        l3out_name      = "cpoc-aci"
        description     = "L3Out to main CPOC ACI fabric built from Terraform"
        vrf = {
          vrf_name        = "cpoc"
        }
        l3_domain       = "dmz-firewall"
        bgp_policy = {
          enabled = true
        }
        ospf_policy = {}
        logical_node_profiles = {
          cpoc-aci-lprof = {
            lprof_name  = "cpoc-aci-lprof"
            description = "Main CPOC ACI fabric L3out Logical Profile created from Terraform"
            bgp_peers = {}
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
              cpoc-aci-intprof = {
                intprof_name  = "cpoc-aci-intprof"
                description   = "Main CPOC ACI fabric L3out Interface Profile created from Terraform"
                ospf_profile = {
                  ospf_policy = {}
                }
                floating_svis = {}
                paths = {
                  path-1 = {
                    description     = "Main CPOC L3Out SVI Path"
                    path_type       = "ext-svi"
                    mac             = "00:22:BD:F8:19:EE"
                    vlan_id         = 1063
                    interface_type  = "vpc"
                    port = {}
                    vpc = {
                      pod      = 1
                      vpc_name = "Lab_Backbone_L2"
                      side_a = {
                        node = 101
                        ip = "100.64.63.245/24"
                      }
                      side_b = {
                        node = 102
                        ip = "100.64.63.246/24"
                      }
                    }
                    bgp_peers = {
                      main-aci = {
                        peer_ip                 = "100.64.63.241"
                        peer_asn                = 65000 # as_number
                        description             = "BGP peer to Main CPOC ACI Fabric. Built by Terraform"
                        ctrl                    = ["send-com", "send-ext-com"] # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
                        local_asn               = 65400
                        route_control_profiles  = {}
                      }
                    }
                  }
                }
              }
            }
          }
        }
        external_epgs = {
          cpoc-lab = {
            extepg_name         = "cpoc-lab"
            description         = "External EPGs and routes advertised to Sydney CPOC ACI fabric"
            preferred_group     = "exclude"
            consumed_contracts = {
              servers-to-cpoc = {
                contract_name = "servers-to-cpoc"
              }
            }
            provided_contracts = {}
            contract_master_epgs = {}
            subnets = {
              N-100-64-64-32-28 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.64.32/28"
                scope = ["export-rtctrl"] #["import-security"], ["import-security","shared-security"]
              }
              N-100-64-64-16-28 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.64.16/28"
                scope = ["export-rtctrl"]
              }
              N-100-64-63-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.63.0/24"
                scope = ["import-security", "shared-security"]
              }
              N-100-64-62-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.62.0/24"
                scope = ["import-security", "shared-security"]
              }
              N-100-64-255-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.255.0/24"
                scope = ["import-security", "shared-security"]
              }
              N-10-1-62-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "10.1.62.0/24"
                scope = ["import-security", "shared-security"]
              }
            }
          }
        }
      }
    }
  }
  contracts = {
    standard = {
      servers-to-cpoc = {
        contract_name = "servers-to-cpoc"
        description   = "Allow all traffic to and from DMZ servers to Main ACI Fabric"
        scope         = "global" # "global", "tenant", "application-profile" and "context"
        subjects = {
          default = {
            subject_name = "default"
            description = "Default subject"
            filters = {
              allow-ipv4 = {
                filter_name = "allow-ipv4"
              }
            }
            service_graph = {
              nodes = {}
            }
          }
        }
      }
    }
    filters = {
      allow-ipv4 = {
        filter_name = "allow-ipv4"
        description = "Allow all IPv4 traffic"
        entries = {
          all-ip = {
            name = "all-ip"
            description = "Allow all IPv4 traffic"
            ether_t       = "ipv4"
            d_from_port   = "unspecified"
            d_to_port     = "unspecified"
            prot          = "unspecified"
            s_from_port   = "unspecified"
            s_to_port     = "unspecified"
          }
        }
      }
    }
  }
  policies = {
    service_redirect_policies = {}
  }
  services = {
    l4-l7 = {
      devices = {}
      service_graph_templates = {}
    }
  }
}
