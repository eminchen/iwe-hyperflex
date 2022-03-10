terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "mel-ciscolabs-com"
    workspaces {
      name = "iwe-hyperflex"
    }
  }
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      # version = "1.0.12"
    }
  }
}

### Providers ###
provider "intersight" {
  # Configuration options
  apikey    = var.intersight_key
  secretkey = var.intersight_secret
  endpoint =  var.intersight_url
}

# ### Intersight Organization ###
# data "intersight_organization_organization" "org" {
#   name = var.org_name
# }

module "hx" {
  source = "./modules/terraform-intersight-hx"

  action              = ""
  wait_for_completion = false
  organization        = var.organization
  tags                = var.tags

  cluster = {
    name                          = var.cluster.name
    description                   = var.cluster.description
    data_ip_address               = var.cluster.data_ip_address
    hypervisor_type               = var.cluster.hypervisor_type
    mac_address_prefix            = var.cluster.mac_address_prefix
    mgmt_ip_address               = var.cluster.mgmt_ip_address
    mgmt_platform                 = var.cluster.mgmt_platform
    replication                   = var.cluster.replication
    host_name_prefix              = var.cluster.host_name_prefix
    storage_data_vlan_name        = var.cluster.storage_data_vlan_name
    storage_data_vlan_id          = var.cluster.storage_data_vlan_id
    storage_cluster_auxiliary_ip  = var.cluster.storage_cluster_auxiliary_ip
    storage_type                  = var.cluster.storage_type
    wwxn_prefix                   = var.cluster.wwxn_prefix

    ### IWE HYPERVISOR ###
    storage_client_ip_address     = var.cluster.storage_client_ip_address
    storage_client_netmask        = var.cluster.storage_client_netmask
    cluster_internal_subnet = {
      gateway                     = var.cluster.cluster_internal_subnet.gateway
      ip_address                  = var.cluster.cluster_internal_subnet.ip_address
      netmask                     = var.cluster.cluster_internal_subnet.netmask
      }
  }

  local_cred_policy = {
    use_existing  = var.local_cred_policy.use_existing
    name          = var.local_cred_policy.name
  }

  sys_config_policy = {
    use_existing  = var.sys_config_policy.use_existing
    name          = var.sys_config_policy.name
  }

  # vcenter_config_policy = {
  #   use_existing = true
  #   name = ""
  # }

  cluster_storage_policy = {
    use_existing  = var.cluster_storage_policy.use_existing
    name          = var.cluster_storage_policy.name
  }

  auto_support_policy = {
    use_existing  = var.auto_support_policy.use_existing
    name          = var.auto_support_policy.name
  }

  node_config_policy = {
    use_existing  = var.node_config_policy.use_existing
    name          = var.node_config_policy.name
  }

  cluster_network_policy = {
    use_existing  = var.cluster_network_policy.use_existing
    name          = var.cluster_network_policy.name
  }

  proxy_setting_policy = {
    use_existing  = var.proxy_setting_policy.use_existing
    name          = var.proxy_setting_policy.name
  }

  # ext_fc_storage_policy = {
  #   use_existing = true
  #   name = ""
  # }
  #
  # ext_iscsi_storage_policy = {
  #   use_existing = true
  #   name = ""
  # }

  software_version_policy = {
    use_existing  = var.software_version_policy.use_existing
    name          = var.software_version_policy.name
  }

  # ucsm_config_policy = {
  #   use_existing = true
  #   name = ""
  # }

}
