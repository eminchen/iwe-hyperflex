terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Toronto_DCLAB"
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
  # experiments = [module_variable_optional_attrs]
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

# module "hx" {
#   source = "./modules/terraform-intersight-hx"
#
#   action              = "Validate"
#   wait_for_completion = false
#   organization        = var.organization
#   tags                = var.tags
#
#   cluster = {
#     name                          = var.cluster.name
#     description                   = var.cluster.description
#     data_ip_address               = var.cluster.data_ip_address
#     hypervisor_type               = var.cluster.hypervisor_type
#     mac_address_prefix            = var.cluster.mac_address_prefix
#     mgmt_ip_address               = var.cluster.mgmt_ip_address
#     mgmt_platform                 = var.cluster.mgmt_platform
#     replication                   = var.cluster.replication
#     host_name_prefix              = var.cluster.host_name_prefix
#     storage_data_vlan             = var.cluster.storage_data_vlan
#     storage_cluster_auxiliary_ip  = var.cluster.storage_cluster_auxiliary_ip
#     storage_type                  = var.cluster.storage_type
#     wwxn_prefix                   = var.cluster.wwxn_prefix
#
#     ### IWE HYPERVISOR ###
#     storage_client_vlan           = var.cluster.storage_client_vlan
#     cluster_internal_subnet       = var.cluster.cluster_internal_subnet
#   }
#
#   local_cred_policy = {
#     use_existing            = var.local_cred_policy.use_existing
#     name                    = var.local_cred_policy.name
#   }
#
#   sys_config_policy               = var.sys_config_policy
#   # vcenter_config_policy = {}
#   # cluster_storage_policy = {}
#   auto_support_policy             = var.auto_support_policy
#   node_config_policy              = var.node_config_policy
#   cluster_network_policy          = var.cluster_network_policy
#   # proxy_setting_policy = {}
#   # ext_fc_storage_policy = {}
#   # ext_iscsi_storage_policy = {}
#
#   software_version_policy = {
#     use_existing            = var.software_version_policy.use_existing
#     name                    = var.software_version_policy.name
#
#     description             = var.software_version_policy.description
#     server_firmware_version = var.software_version_policy.server_firmware_version
#     hypervisor_version      = var.software_version_policy.hypervisor_version
#     hxdp_version            = var.software_version_policy.hxdp_version
#   }
#
#   # ucsm_config_policy = {}
#
# }

module "hx" {
  source  = "cisco-apjc-cloud-se/hx/intersight"
  version = "1.0.2" 
  
  action              = var.action
  wait_for_completion = false
  organization        = var.organization
  tags                = var.tags

  cluster                         = var.cluster
  nodes                           = var.nodes
  local_cred_policy               = var.local_cred_policy
  sys_config_policy               = var.sys_config_policy
  # vcenter_config_policy           = var.vcenter_config_policy
  # cluster_storage_policy = {}
  auto_support_policy             = var.auto_support_policy
  node_config_policy              = var.node_config_policy
  cluster_network_policy          = var.cluster_network_policy
  # proxy_setting_policy = {}
  # ext_fc_storage_policy = {}
  # ext_iscsi_storage_policy = {}
  software_version_policy         = var.software_version_policy
  # ucsm_config_policy = {}

}
