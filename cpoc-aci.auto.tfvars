# ### Tenants ###
# tenants = {
#   common = {
#     name = "common"
#     use_existing = true
#     aps = {}
#     networking = {
#       vrfs = {
#         cpoc = {
#           vrf_name    = "cpoc"
#           description = "Common VRF for routed access to main CPOC ACI fabric"
#           preferred_group = "disabled"
#         }
#       }
#       bds = {}
#       l3outs = {
#         cpoc-aci = {
#           l3out_name      = "cpoc-aci"
#           description     = "L3Out to main CPOC ACI fabric built from Terraform"
#           vrf = {
#             vrf_name        = "cpoc"
#           }
#           l3_domain       = "dmz-firewall"
#           ospf_policy = {}
#           logical_node_profiles = {
#             cpoc-aci-lprof = {
#               lprof_name  = "cpoc-aci-lprof"
#               description = "Main CPOC ACI fabric L3out Logical Profile created from Terraform"
#               bgp_peers = {
#                 main-aci = {
#                   peer_ip                 = "100.64.63.241"
#                   peer_asn                = 65000 # as_number
#                   description             = "BGP peer to Main CPOC ACI Fabric. Built by Terraform"
#                   ctrl                    = "send-com, send-ext-com" # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
#                   local_asn               = 65400
#                   route_control_profiles  = {}
#                 }
#               }
#               nodes = {
#                 node-1 = {
#                   pod = 1
#                   leaf_node = 101
#                   loopback_ip = "101.1.1.1"
#                 }
#                 node-2 = {
#                   pod = 1
#                   leaf_node = 102
#                   loopback_ip = "102.1.1.1"
#                 }
#               }
#               interface_profiles = {
#                 cpoc-aci-intprof = {
#                   intprof_name  = "cpoc-aci-intprof"
#                   description   = "Main CPOC ACI fabric L3out Interface Profile created from Terraform"
#                   ospf_profile = {}
#                   floating_svis = {}
#                   paths = {
#                     path-1 = {
#                       description     = "Main CPOC L3Out SVI Path"
#                       path_type       = "ext-svi"
#                       mac             = "00:22:BD:F8:19:EE"
#                       vlan_id         = 1063
#                       interface_type  = "vpc"
#                       port = {}
#                       vpc = {
#                         pod      = 1
#                         vpc_name = "Lab_Backbone_L2"
#                         side_a = {
#                           node = 101
#                           ip = "100.64.63.245/24"
#                         }
#                         side_b = {
#                           node = 102
#                           ip = "100.64.63.246/24"
#                         }
#                       }
#                     }
#                   }
#                 }
#               }
#             }
#           }
#           external_epgs = {
#             cpoc-lab = {
#               extepg_name         = "cpoc-lab"
#               description         = "External EPGs and routes advertised to Sydney CPOC ACI fabric"
#               preferred_group     = "exclude"
#               consumed_contracts = {
#                 servers-to-cpoc = {
#                   contract_name = "servers-to-cpoc"
#                 }
#               }
#               provided_contracts = {}
#               contract_master_epgs = {}
#               subnets = {
#                 N-100-64-64-32-28 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.64.32/28"
#                   scope = ["export-rtctrl"] #["import-security"], ["import-security","shared-security"]
#                 }
#                 N-100-64-64-16-28 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.64.16/28"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-100-64-63-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.63.0/24"
#                   scope = ["import-security", "shared-security"]
#                 }
#                 N-100-64-62-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.62.0/24"
#                   scope = ["import-security", "shared-security"]
#                 }
#                 N-100-64-255-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.255.0/24"
#                   scope = ["import-security", "shared-security"]
#                 }
#                 N-10-1-62-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "10.1.62.0/24"
#                   scope = ["import-security", "shared-security"]
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#     contracts = {
#       standard = {
#         servers-to-cpoc = {
#           contract_name = "servers-to-cpoc"
#           description   = "Allow all traffic to and from DMZ servers to Main ACI Fabric"
#           scope         = "global" # "global", "tenant", "application-profile" and "context"
#           subjects = {
#             default = {
#               subject_name = "default"
#               description = "Default subject"
#               filters = {
#                 allow-ipv4 = {
#                   filter_name = "allow-ipv4"
#                 }
#               }
#               service_graph = {
#                 nodes = {}
#               }
#             }
#           }
#         }
#       }
#       filters = {
#         allow-ipv4 = {
#           filter_name = "allow-ipv4"
#           description = "Allow all IPv4 traffic"
#           entries = {
#             all-ip = {
#               name = "all-ip"
#               description = "Allow all IPv4 traffic"
#               ether_t       = "ipv4"
#               d_from_port   = "unspecified"
#               d_to_port     = "unspecified"
#               prot          = "unspecified"
#               s_from_port   = "unspecified"
#               s_to_port     = "unspecified"
#             }
#           }
#         }
#       }
#     }
#     policies = {
#       service_redirect_policies = {}
#     }
#     services = {
#       l4-l7 = {
#         devices = {}
#         service_graph_templates = {}
#       }
#     }
#   }
#   tf-aci-cpoc = {
#     name        = "tf-aci-cpoc"
#     use_existing    = false
#     description = "Demo ACI Tenant built from Terraform Cloud. Do not delete"
#     aps = {
#       external = {
#         ap_name = "external"
#         tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
#         description = "App Profile for External VLANs"
#         esgs = {}
#         epgs = {
#           internet-vl85 = {
#             epg_name = "internet-85"
#             bd = {
#               bd_name = "ext-85"       ## Bridge Domain to add EPG to
#             }
#             description = "EPG for External DMZ VLAN 85 in Demo ACI Tenant"
#             domains = {
#               vmm = {
#                 name = "CPOC-SE-VC-HX"
#                 type = "vmware"
#               }
#               phys = {
#                 name = "phys"
#                 type = "physical"
#               }
#             }
#             mapped_esg = {}
#             preferred_group = "exclude"
#             paths = {
#               path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
#                 pod       = 1
#                 leaf_node = 101
#                 port      = "eth1/46"
#                 vlan_id   = 85
#                 mode      = "regular" # regular, native, untagged
#               }
#             }
#           }
#         }
#       }
#       dmz = {
#         ap_name = "dmz"
#         tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
#         description = "App Profile for DMZ VLANs"
#         esgs = {
#           iks-esg = {
#             esg_name        = "iks-esg"
#             description     = "IKS Host ESG"
#             preferred_group = "exclude"
#             vrf = {
#               vrf_name        = "internal"
#             }
#             consumed_contracts = {
#               servers-to-internet = {
#                 contract_name = "servers-to-internet"
#               }
#               # c-2 = {
#               #   contract_name = "servers-to-cpoc"
#               # }
#             }
#             provided_contracts = {
#               # NOTE: Gets removed as this a shared contract - need method to use data source
#               servers-to-cpoc = {
#                 tenant_name   = "common"
#                 contract_name = "servers-to-cpoc"
#               }
#             }
#           }
#         }
#         epgs = {
#           iks-1 = {
#             epg_name = "iks-1"
#             bd = {
#               bd_name = "dmz"       ## Bridge Domain to add EPG to
#             }
#             description = "EPG for DMZ IKS Cluster #1 in Demo ACI Tenant"
#             domains = {
#               vmm = {
#                 name = "CPOC-SE-VC-HX"
#                 type = "vmware"
#               }
#               phys = {
#                 name = "phys"
#                 type = "physical"
#               }
#             }
#             mapped_esg = {
#               esg_name = "iks-esg"
#             }
#             preferred_group = "exclude"
#             paths = {}
#           }
#           iks-2 = {
#             epg_name = "iks-2"
#             bd = {
#               bd_name = "dmz"       ## Bridge Domain to add EPG to
#             }
#             description = "EPG for DMZ IKS Cluster #2 in Demo ACI Tenant"
#             domains = {
#               vmm = {
#                 name = "CPOC-SE-VC-HX"
#                 type = "vmware"
#               }
#               phys = {
#                 name = "phys"
#                 type = "physical"
#               }
#             }
#             mapped_esg = {
#               esg_name = "iks-esg"
#             }
#             preferred_group = "exclude"
#             paths = {}
#           }
#         }
#       }
#     }
#     networking = {
#       vrfs = {
#         external = {
#           vrf_name    = "external"
#           description = "External VRF for Demo ACI Tenant.  Not expected to be used."
#           preferred_group = "disabled"
#         }
#         internal = {
#           vrf_name    = "internal"
#           description = "Internal VRF for Demo ACI Tenant.  Preferred Group enabled."
#           preferred_group = "enabled"
#         }
#       }
#       bds = {
#         ext-85 = {
#           bd_name     = "ext-85"
#           vrf = {
#             vrf_name    = "external"      ## VRF to add BD to
#           }
#           description = " Bridge Domain for External VLAN 85 in Demo ACI Tenant"
#           mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
#           arp_flood   = "yes" ## "yes", "no"
#           l3outs      = {}
#           subnets = {}
#         }
#         dmz = {
#           bd_name     = "dmz"
#           vrf = {
#             vrf_name    = "internal"      ## VRF to add BD to
#           }
#           description = " Bridge Domain for Demo DMZ in Demo ACI Tenant"
#           mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
#           arp_flood   = "yes" ## "yes", "no"
#           l3outs      = {}
#           subnets = {
#             ### NOTE: CPOC Lab L3Out needs manual export entry in common tenant ExEPG
#             ### NOTE: Need to add subnet to VRF leaking - manual
#             sub-1 = {
#               ip          = "100.64.64.17/28"
#               description = "Primary Subnet for DMZ BD"
#               scope       = ["public","shared"]
#               preferred   = "yes"
#             }
#             sub-2 = {
#               ip          = "100.64.64.33/28"
#               description = "2nd Subnet for DMZ BD"
#               scope       = ["public","shared"]
#               preferred   = "no"
#             }
#           }
#         }
#       }
#       l3outs = {
#         dmz-firewall = {
#           l3out_name      = "dmz-firewall"
#           description     = "DMZ FTDv Firewall L3Out built from Terraform"
#           vrf = {
#             vrf_name        = "internal"
#           }
#           l3_domain       = "dmz-firewall"
#           ospf_policy = {
#             enabled     = true
#             description = "OSPF Peering to DMZ FTDv Firewall"
#             area_cost   = 0
#             area_id     = "0.0.0.0"
#             area_type   = "regular"
#           }
#           logical_node_profiles = {
#             lprof-1 = {
#               lprof_name  = "dmz-firewall"
#               description = "DMZ FTDv Firewall Logical Profile created from Terraform"
#               bgp_peers = {}
#               nodes = {
#                 node-1 = {
#                   pod = 1
#                   leaf_node = 101
#                   loopback_ip = "101.1.1.1"
#                 }
#                 node-2 = {
#                   pod = 1
#                   leaf_node = 102
#                   loopback_ip = "102.1.1.1"
#                 }
#               }
#               interface_profiles = {
#                 intprof-1 = {
#                   intprof_name  = "dmz-firewall"
#                   description   = "DMZ Firewall Interface Profile created from Terraform"
#                   ospf_profile = {
#                     enabled = true
#                     description = "OSPF Interface Auth and Policy Config"
#                     auth_key    = "key"
#                     auth_key_id = 255
#                     auth_type   = "none"
#                     ospf_policy = {}
#                   }
#                   floating_svis = {
#                     node-101 = {
#                       pod         = 1
#                       node        = 101
#                       vlan_id     = 301
#                       ip          = "100.64.64.2/28"
#                       description = "Floating SVI to DMZ-FW Node 101"
#                       domains = {
#                         vmm = {
#                           name              = "CPOC-SE-VC-HX"
#                           type              = "vmware"
#                           floating_ip       = "100.64.64.1/28"
#                           forged_transmit   = "Enabled"
#                           mac_change        = "Enabled"
#                           promiscuous_mode  = "Enabled"
#                         }
#                       }
#                     }
#                     node-102 = {
#                       pod         = 1
#                       node        = 102
#                       vlan_id     = 301
#                       ip          = "100.64.64.3/28"
#                       description = "Floating SVI to DMZ FW Node 102"
#                       domains = {}
#                     }
#                   }
#                   paths = {}
#                 }
#               }
#             }
#           }
#           external_epgs = {
#             cpoc-internet = {
#               extepg_name         = "cpoc-internet"
#               description         = "Public Internet from Sydney CPOC"
#               preferred_group     = "exclude"
#               consumed_contracts = {}
#               provided_contracts = {
#                 p-1 = {
#                   contract_name = "servers-to-internet"
#                 }
#               }
#               contract_master_epgs = {}
#               subnets = {
#                 N-0-0-0-0-0 = {
#                   description = "0.0.0.0/0"
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "0.0.0.0/0"
#                   scope = ["import-security"]
#                 }
#               }
#             }
#             cpoc-dmz = {
#               extepg_name         = "cpoc-dmz"
#               description         = "Advertise networks to DMZ Firewall"
#               preferred_group     = "exclude"
#               consumed_contracts = {}
#               provided_contracts = {}
#               contract_master_epgs = {}
#               subnets = {
#                 N-100-64-64-32-28 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.64.32/28"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-100-64-64-16-28 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.64.16/28"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-100-64-63-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.63.0/24"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-100-64-62-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.62.0/24"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-100-64-255-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "100.64.255.0/24"
#                   scope = ["export-rtctrl"]
#                 }
#                 N-10-1-62-0-24 = {
#                   description = ""
#                   aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
#                   ip = "10.1.62.0/24"
#                   scope = ["export-rtctrl"]
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#     contracts = {
#       standard = {
#         # servers-to-cpoc = {
#         #   ## NOTE: Use existing contract from common tenant - won't create new contract
#         #   contract_name = "servers-to-cpoc"
#         #   tenant_name   = "common"    ## Tenant to add filter to
#         #   use_existing = true
#         # }
#         servers-to-internet = {
#           contract_name = "servers-to-internet"
#           use_existing = false
#           description   = "Allow all traffic from DMZ servers to Internet via CPOC DMZ firewall"
#           scope         = "context" # "global", "tenant", "application-profile" and "context"
#           subjects = {
#             default = {
#               subject_name = "default"
#               description = "Default subject"
#               filters = {
#                 allow-ipv4 = {
#                   filter_name = "allow-ipv4"
#                 }
#               }
#               service_graph = {
#                 nodes = {}
#               }
#             }
#           }
#         }
#       }
#       filters = {
#         allow-ipv4 = {
#           filter_name = "allow-ipv4"
#           description = "Allow all IPv4 traffic"
#           entries = {
#             all-ip = {
#               name = "all-ip"
#               description = "Allow all IPv4 traffic"
#               ether_t       = "ipv4"
#               d_from_port   = "unspecified"
#               d_to_port     = "unspecified"
#               prot          = "unspecified"
#               s_from_port   = "unspecified"
#               s_to_port     = "unspecified"
#             }
#           }
#         }
#       }
#     }
#     policies = {
#       service_redirect_policies = {}
#     }
#     services = {
#       l4-l7 = {
#         devices = {}
#         service_graph_templates = {}
#       }
#     }
#   }
# }

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
        ospf_policy = {}
        logical_node_profiles = {
          cpoc-aci-lprof = {
            lprof_name  = "cpoc-aci-lprof"
            description = "Main CPOC ACI fabric L3out Logical Profile created from Terraform"
            bgp_peers = {
              main-aci = {
                peer_ip                 = "100.64.63.241"
                peer_asn                = 65000 # as_number
                description             = "BGP peer to Main CPOC ACI Fabric. Built by Terraform"
                ctrl                    = "send-com, send-ext-com" # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
                local_asn               = 65400
                route_control_profiles  = {}
              }
            }
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
                ospf_profile = {}
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

### Terraform Demo Tenant Configuration ###
demo_tenant = {
  name        = "tf-aci-cpoc"
  use_existing    = false
  description = "Demo ACI Tenant built from Terraform Cloud. Do not delete"
  aps = {
    external = {
      ap_name = "external"
      tenant_name = "tf-aci-cpoc"    ## Tenant to add AP to
      description = "App Profile for External VLANs"
      esgs = {}
      epgs = {
        internet-vl85 = {
          epg_name = "internet-85"
          bd = {
            bd_name = "ext-85"       ## Bridge Domain to add EPG to
          }
          description = "EPG for External DMZ VLAN 85 in Demo ACI Tenant"
          domains = {
            vmm = {
              name = "CPOC-SE-VC-HX"
              type = "vmware"
            }
            phys = {
              name = "phys"
              type = "physical"
            }
          }
          mapped_esg = {}
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
      esgs = {
        iks-esg = {
          esg_name        = "iks-esg"
          description     = "IKS Host ESG"
          preferred_group = "exclude"
          vrf = {
            vrf_name        = "internal"
          }
          consumed_contracts = {
            servers-to-internet = {
              contract_name = "servers-to-internet"
            }
            # c-2 = {
            #   contract_name = "servers-to-cpoc"
            # }
          }
          provided_contracts = {
            # NOTE: Gets removed as this a shared contract - need method to use data source
            servers-to-cpoc = {
              tenant_name   = "common"
              contract_name = "servers-to-cpoc"
            }
          }
        }
      }
      epgs = {
        iks-1 = {
          epg_name = "iks-1"
          bd = {
            bd_name = "dmz"       ## Bridge Domain to add EPG to
          }
          description = "EPG for DMZ IKS Cluster #1 in Demo ACI Tenant"
          domains = {
            vmm = {
              name = "CPOC-SE-VC-HX"
              type = "vmware"
            }
            phys = {
              name = "phys"
              type = "physical"
            }
          }
          mapped_esg = {
            esg_name = "iks-esg"
          }
          preferred_group = "exclude"
          paths = {}
        }
        iks-2 = {
          epg_name = "iks-2"
          bd = {
            bd_name = "dmz"       ## Bridge Domain to add EPG to
          }
          description = "EPG for DMZ IKS Cluster #2 in Demo ACI Tenant"
          domains = {
            vmm = {
              name = "CPOC-SE-VC-HX"
              type = "vmware"
            }
            phys = {
              name = "phys"
              type = "physical"
            }
          }
          mapped_esg = {
            esg_name = "iks-esg"
          }
          preferred_group = "exclude"
          paths = {}
        }
      }
    }
  }
  networking = {
    vrfs = {
      external = {
        vrf_name    = "external"
        description = "External VRF for Demo ACI Tenant.  Not expected to be used."
        preferred_group = "disabled"
      }
      internal = {
        vrf_name    = "internal"
        description = "Internal VRF for Demo ACI Tenant.  Preferred Group enabled."
        preferred_group = "enabled"
      }
    }
    bds = {
      ext-85 = {
        bd_name     = "ext-85"
        vrf = {
          vrf_name    = "external"      ## VRF to add BD to
        }
        description = " Bridge Domain for External VLAN 85 in Demo ACI Tenant"
        mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
        arp_flood   = "yes" ## "yes", "no"
        l3outs      = {}
        subnets = {}
      }
      dmz = {
        bd_name     = "dmz"
        vrf = {
          vrf_name    = "internal"      ## VRF to add BD to
        }
        description = " Bridge Domain for Demo DMZ in Demo ACI Tenant"
        mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
        arp_flood   = "yes" ## "yes", "no"
        l3outs      = {}
        subnets = {
          ### NOTE: CPOC Lab L3Out needs manual export entry in common tenant ExEPG
          ### NOTE: Need to add subnet to VRF leaking - manual
          sub-1 = {
            ip          = "100.64.64.17/28"
            description = "Primary Subnet for DMZ BD"
            scope       = ["public","shared"]
            preferred   = "yes"
          }
          sub-2 = {
            ip          = "100.64.64.33/28"
            description = "2nd Subnet for DMZ BD"
            scope       = ["public","shared"]
            preferred   = "no"
          }
        }
      }
    }
    l3outs = {
      dmz-firewall = {
        l3out_name      = "dmz-firewall"
        description     = "DMZ FTDv Firewall L3Out built from Terraform"
        vrf = {
          vrf_name        = "internal"
        }
        l3_domain       = "dmz-firewall"
        ospf_policy = {
          enabled     = true
          description = "OSPF Peering to DMZ FTDv Firewall"
          area_cost   = 0
          area_id     = "0.0.0.0"
          area_type   = "regular"
        }
        logical_node_profiles = {
          lprof-1 = {
            lprof_name  = "dmz-firewall"
            description = "DMZ FTDv Firewall Logical Profile created from Terraform"
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
              intprof-1 = {
                intprof_name  = "dmz-firewall"
                description   = "DMZ Firewall Interface Profile created from Terraform"
                ospf_profile = {
                  enabled = true
                  description = "OSPF Interface Auth and Policy Config"
                  auth_key    = "key"
                  auth_key_id = 255
                  auth_type   = "none"
                  ospf_policy = {}
                }
                floating_svis = {
                  node-101 = {
                    pod         = 1
                    node        = 101
                    vlan_id     = 301
                    ip          = "100.64.64.2/28"
                    description = "Floating SVI to DMZ-FW Node 101"
                    domains = {
                      vmm = {
                        name              = "CPOC-SE-VC-HX"
                        type              = "vmware"
                        floating_ip       = "100.64.64.1/28"
                        forged_transmit   = "Enabled"
                        mac_change        = "Enabled"
                        promiscuous_mode  = "Enabled"
                      }
                    }
                  }
                  node-102 = {
                    pod         = 1
                    node        = 102
                    vlan_id     = 301
                    ip          = "100.64.64.3/28"
                    description = "Floating SVI to DMZ FW Node 102"
                    domains = {}
                  }
                }
                paths = {}
              }
            }
          }
        }
        external_epgs = {
          cpoc-internet = {
            extepg_name         = "cpoc-internet"
            description         = "Public Internet from Sydney CPOC"
            preferred_group     = "exclude"
            consumed_contracts = {}
            provided_contracts = {
              p-1 = {
                contract_name = "servers-to-internet"
              }
            }
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
          cpoc-dmz = {
            extepg_name         = "cpoc-dmz"
            description         = "Advertise networks to DMZ Firewall"
            preferred_group     = "exclude"
            consumed_contracts = {}
            provided_contracts = {}
            contract_master_epgs = {}
            subnets = {
              N-100-64-64-32-28 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.64.32/28"
                scope = ["export-rtctrl"]
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
                scope = ["export-rtctrl"]
              }
              N-100-64-62-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.62.0/24"
                scope = ["export-rtctrl"]
              }
              N-100-64-255-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "100.64.255.0/24"
                scope = ["export-rtctrl"]
              }
              N-10-1-62-0-24 = {
                description = ""
                aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                ip = "10.1.62.0/24"
                scope = ["export-rtctrl"]
              }
            }
          }
        }
      }
    }
  }
  contracts = {
    standard = {
      # servers-to-cpoc = {
      #   ## NOTE: Use existing contract from common tenant - won't create new contract
      #   contract_name = "servers-to-cpoc"
      #   tenant_name   = "common"    ## Tenant to add filter to
      #   use_existing = true
      # }
      servers-to-internet = {
        contract_name = "servers-to-internet"
        use_existing = false
        description   = "Allow all traffic from DMZ servers to Internet via CPOC DMZ firewall"
        scope         = "context" # "global", "tenant", "application-profile" and "context"
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
