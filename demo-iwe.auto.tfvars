action              = "No-op"
wait_for_completion = false
organization        = "default"
tags                = []

cluster = {
  ### COMMON SETTINGS ###
  name                          = "tf-hx-iwe"
  description                   = "HX Cluster deployed by Terrafrom"
  data_ip_address               = "169.254.0.1" # 169.254.0.1
  hypervisor_control_ip_address = "172.31.255.2"
  hypervisor_type               = "IWE" # ESXi, IWE
  mac_address_prefix            = "00:25:B5:00"
  mgmt_ip_address               = "10.67.29.138"
  mgmt_platform                 = "FI" # FI, EDGE
  replication                   = 3
  host_name_prefix              = "tf-hx-iwe"

  storage_data_vlan = {
    name    = "HX-STR-DATA-103"
    vlan_id = 103
    }

  # storage_cluster_auxiliary_ip  = ""
  # storage_type                  = "" # HyperFlexDp, ThirdParty
  # wwxn_prefix                   = ""

  # ### IWE HYPERVISOR ONLY ###
  storage_client_vlan = {
    name        = "HX-STR-CLIENT-104"
    vlan_id     = 104
    ip_address  = "169.254.240.1"
    netmask     = "255.255.248.0" # 255.255.248.0 hard set!
    }

  cluster_internal_subnet = {
    gateway                     = "192.168.0.1"
    ip_address                  = "192.168.0.0"
    netmask                     = "255.255.0.0"
    }

  }

nodes = ["WZP23470VYT", "WZP23470VYJ", "WZP23470VYE"]  ## List of node serial numbers to assign to cluster

local_cred_policy = {
  use_existing  = true
  name          = "mel-dc4-hx1-local-credential-policy"
}

sys_config_policy = {
  use_existing  = true
  name          = "mel-dc4-hx1-sys-config-policy"
}

# vcenter_config_policy = {
#   use_existing  = true
#   name          = "mel-dc4-hx1-vcenter-config-policy"
# }

# cluster_storage_policy = {
#   use_existing  = true
#   name          = ""
# }

auto_support_policy = {
  use_existing  = true
  name          = "mel-dc4-hx1-auto-support-policy"
}

node_config_policy = {
  use_existing  = true
  name          = "mel-dc4-hx1-node-config-policy"
}

cluster_network_policy = {
  use_existing  = true
  # name          = "mel-dc4-iwe-cluster-network-policy"
  name          = "mel-dc4-hx1-cluster-network-policy"
}

# proxy_setting_policy = {
#   use_existing  = true
#   name          = ""
# }

# ext_fc_storage_policy = {
#   use_existing = true
#   name = ""
# }

# ext_iscsi_storage_policy = {
#   use_existing = true
#   name = ""
# }

software_version_policy = {
  use_existing            = false
  name                    = "tf-iwe-sw-version"

  description             = "HX IWE cluster software version policy created by Terraform"
  server_firmware_version = "4.2(1l)"
  hypervisor_version      = "1.2(1a)"
  hxdp_version            = "4.5(2b)"
}

# ucsm_config_policy = {
#   use_existing = true
#   name = ""
# }
