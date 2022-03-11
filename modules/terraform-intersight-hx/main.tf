#Importing existing components if they exist.
data "intersight_hyperflex_local_credential_policy" "this" {
  count = var.local_cred_policy.use_existing == true ? 1 : 0
  name  = var.local_cred_policy.name
}

data "intersight_hyperflex_sys_config_policy" "this" {
  count = var.sys_config_policy.use_existing == true ? 1 : 0
  name  = var.sys_config_policy.name
}

data "intersight_hyperflex_vcenter_config_policy" "this" {
  count = var.vcenter_config_policy.use_existing == true && var.cluster.hypervisor_type == "ESXi" ? 1 : 0
  name  = var.vcenter_config_policy.name
}

data "intersight_hyperflex_cluster_storage_policy" "this" {
  count = var.cluster_storage_policy.use_existing == true ? 1 : 0
  name  = var.cluster_storage_policy.name
}

data "intersight_hyperflex_auto_support_policy" "this" {
  count = var.auto_support_policy.use_existing == true ? 1 : 0
  name  = var.auto_support_policy.name
}

data "intersight_hyperflex_node_config_policy" "this" {
  count = var.node_config_policy.use_existing == true ? 1 : 0
  name  = var.node_config_policy.name
}

data "intersight_hyperflex_cluster_network_policy" "this" {
  count = var.cluster_network_policy.useExisting == true ? 1 : 0
  name  = var.cluster_network_policy.name
}

data "intersight_hyperflex_proxy_setting_policy" "this" {
  count = var.proxy_setting_policy.use_existing == true ? 1 : 0
  name  = var.proxy_setting_policy.name
}

data "intersight_hyperflex_ext_fc_storage_policy" "this" {
  count = var.ext_fc_storage_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 1 : 0
  name  = var.ext_fc_storage_policy.name
}

data "intersight_hyperflex_ext_iscsi_storage_policy" "this" {
  count = var.ext_iscsi_storage_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 1 : 0
  name  = var.ext_iscsi_storage_policy.name
}

data "intersight_hyperflex_software_version_policy" "this" {
  count = var.software_version_policy.use_existing == true ? 1 : 0
  name  = var.software_version_policy.name
}

data "intersight_hyperflex_ucsm_config_policy" "this" {
  count = var.ucsm_config_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 1 : 0
  name  = var.ucsm_config_policy.name
}

### Sub Modules for Conditional Policy Creation ###

module "local_cred_policy" {
  source        = "./modules/local_cred_policy"
  count         = var.local_cred_policy.use_existing == true ? 0 : 1

  organization  = var.organization
  tags          = var.tags

  name                        = var.local_cred_policy.name
  hxdp_root_pwd               = var.local_cred_policy.hxdp_root_pwd
  hypervisor_admin            = var.local_cred_policy.hypervisor_admin # "admin"
  hypervisor_admin_pwd        = var.local_cred_policy.hypervisor_admin_pwd
  factory_hypervisor_password = var.local_cred_policy.factory_hypervisor_password # Bool - false
}

module "sys_config_policy" {
  source      = "./modules/sys_config_policy"
  count       = var.sys_config_policy.use_existing == true ? 0 : 1

  name            = var.sys_config_policy.name
  description     = var.sys_config_policy.description
  dns_domain_name = var.sys_config_policy.dns_domain_name
  dns_servers     = var.sys_config_policy.dns_servers
  ntp_servers     = var.sys_config_policy.ntp_servers
  timezone        = var.sys_config_policy.timezone

  organization  = var.organization
  tags          = var.tags
}

module "vcenter_config_policy" {
  ## Not supported by IWE ##
  source      = "./modules/vcenter_config_policy"
  count       = var.vcenter_config_policy.use_existing == true && var.cluster.hypervisor_type == "ESXi" ? 0 : 1

  name        = var.vcenter_config_policy.name
  description = var.vcenter_config_policy.description
  data_center = var.vcenter_config_policy.data_center
  hostname    = var.vcenter_config_policy.hostname
  password    = var.vcenter_config_policy.password
  sso_url     = var.vcenter_config_policy.sso_url
  username    = var.vcenter_config_policy.username

  organization  = var.organization
  tags          = var.tags
}

module "cluster_storage_policy" {
  ## Not supported by IWE ##
  source      = "./modules/cluster_storage_policy"
  count       = var.cluster_storage_policy.use_existing == true && var.cluster.hypervisor_type == "ESXi" ? 0 : 1

  name                            = var.cluster_storage_policy.name
  description                     = var.cluster_storage_policy.description
  disk_partition_cleanup          = var.cluster_storage_policy.disk_partition_cleanup
  vdi_optimization                = var.cluster_storage_policy.vdi_optimization
  logical_avalability_zone_config = var.cluster_storage_policy.logical_avalability_zone_config

  organization  = var.organization
  tags          = var.tags
}

module "auto_support_policy" {
  source      = "./modules/auto_support_policy"
  count       = var.auto_support_policy.use_existing == true ? 0 : 1

  name                      = var.auto_support_policy.name
  description               = var.auto_support_policy.description
  admin_state               = var.auto_support_policy.admin_state
  service_ticket_receipient = var.auto_support_policy.service_ticket_receipient

  organization  = var.organization
  tags          = var.tags
}

module "node_config_policy" {
  source      = "./modules/node_config_policy"
  count       = var.node_config_policy.use_existing == true ? 0 : 1

  name                        = var.node_config_policy.name
  description                 = var.node_config_policy.escription
  node_name_prefix            = var.node_config_policy.node_name_prefix
  data_ip_range               = var.node_config_policy.data_ip_range
  hxdp_ip_range               = var.node_config_policy.hxdp_ip_range
  hypervisor_control_ip_range = var.node_config_policy.hypervisor_control_ip_range
  mgmt_ip_range               = var.node_config_policy.mgmt_ip_range

  organization  = var.organization
  tags          = var.tags
}

module "cluster_network_policy" {
  source      = "./modules/cluster_network_policy"
  count       = var.cluster_network_policy.use_existing == true ? 0 : 1

  name                = var.name
  description         = var.description
  jumbo_frame         = var.jumbo_frame
  uplink_speed        = var.uplink_speed
  mac_prefix_range    = var.mac_prefix_range
  mgmt_vlan           = var.mgmt_vlan
  vm_migration_vlan   = var.vm_migration_vlan
  vm_network_vlans    = var.vm_network_vlans

  organization  = var.organization
  tags          = var.tags
}

module "proxy_setting_policy" {
  source      = "./modules/proxy_setting_policy"
  count       = var.proxy_setting_policy.use_existing == true ? 0 : 1

  name          = var.proxy_setting_policy.name
  description   = var.proxy_setting_policy.description
  hostname      = var.proxy_setting_policy.hostname
  password      = var.proxy_setting_policy.password
  port          = var.proxy_setting_policy.port
  username      = var.proxy_setting_policy.username

  organization  = var.organization
  tags          = var.tags
}

module "ext_fc_storage_policy" {
  source      = "./modules/ext_fc_storage_policy"
  count       = var.ext_fc_storage_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 0 : 1

  name              = var.ext_fc_storage_policy.name
  description       = var.ext_fc_storage_policy.description
  admin_state       = var.ext_fc_storage_policy.admin_state
  exta_traffic      = var.ext_fc_storage_policy.exta_traffic
  extb_traffic      = var.ext_fc_storage_policy.extb_traffic
  wwxn_prefix_range = var.ext_fc_storage_policy.wwxn_prefix_range

  organization  = var.organization
  tags          = var.tags
}

module "ext_iscsi_storage_policy" {
  source      = "./modules/ext_iscsi_storage_policy"
  count       = var.ext_iscsi_storage_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 0 : 1

  name              = var.ext_iscsi_storage_policy.name
  description       = var.ext_iscsi_storage_policy.description
  admin_state       = var.ext_iscsi_storage_policy.admin_state
  exta_traffic      = var.ext_iscsi_storage_policy.exta_traffic
  extb_traffic      = var.ext_iscsi_storage_policy.extb_traffic

  organization  = var.organization
  tags          = var.tags
}

module "software_version_policy" {
  source      = "./modules/software_version_policy"
  count       = var.software_version_policy.use_existing == true ? 0 : 1

  name                    = var.software_version_policy.name
  description             = var.software_version_policy.description
  server_firmware_version = var.software_version_policy.server_firmware_version
  hypervisor_version      = var.software_version_policy.hypervisor_version
  hxdp_version            = var.software_version_policy.hxdp_version
}

module "ucsm_config_policy" {
  source      = "./modules/ucsm_config_policy"
  count       = var.ucsm_config_policy.use_existing == true && var.cluster.mgmt_platform == "FI" ? 0 : 1

  name                    = var.ucsm_config_policy.name
  description             = var.ucsm_config_policy.description
  server_firmware_version = var.ucsm_config_policy.server_firmware_version
  kvm_ip_range            = var.ucsm_config_policy.kvm_ip_range

  organization  = var.organization
  tags          = var.tags
}

### Main Cluster Profile ###

module "cluster_profile" {
  source              = "./modules/cluster_profile"

  action              = var.action
  wait_for_completion = var.wait_for_completion # Need?
  organization        = var.organization
  tags                = var.tags

  name                = var.cluster.name
  description         = var.cluster.description
  data_ip_address     = var.cluster.data_ip_address
  hypervisor_type     = var.cluster.hypervisor_type # ESXi vs IWE
  mac_address_prefix  = var.cluster.mac_address_prefix
  mgmt_ip_address     = var.cluster.mgmt_ip_address
  mgmt_platform       = var.cluster.mgmt_platform  # FI vs EDGE
  replication         = var.cluster.replication
  host_name_prefix    = var.cluster.host_name_prefix

  storage_data_vlan       = var.cluster.storage_data_vlan

  storage_cluster_auxiliary_ip  = var.cluster.storage_cluster_auxiliary_ip #?
  storage_type                  = var.cluster.storage_type #?
  wwxn_prefix                   = var.cluster.wwxn_prefix #?

  ## IWE HYPERVISOR OPTIONAL ##
  storage_client_vlan_name      = var.cluster.storage_client_vlan_name
  storage_client_vlan_id        = var.cluster.storage_client_vlan_id
  storage_client_ip_address     = var.cluster.storage_client_ip_address
  storage_client_netmask        = var.cluster.storage_client_netmask
  cluster_internal_subnet       = var.cluster.cluster_internal_subnet
  # cluster_internal_subnet_gateway     = var.cluster.cluster_internal_subnet.gateway
  # cluster_internal_subnet_ip_address  = var.cluster.cluster_internal_subnet.ip_address
  # cluster_internal_subnet_netmask     = var.cluster.cluster_internal_subnet.netmask

  ### COMMON REQUIRED POLICIES ###
  local_cred_policy_moid        = var.local_cred_policy.use_existing == true ? data.intersight_hyperflex_local_credential_policy.this.0.results.0.moid : module.local_cred_policy.0.moid
  sys_config_policy_moid        = var.sys_config_policy.use_existing == true ? data.intersight_hyperflex_sys_config_policy.this.0.results.0.moid : module.sys_config_policy.0.moid
  node_config_policy_moid       = var.node_config_policy.use_existing == true ? data.intersight_hyperflex_node_config_policy.this.0.results.0.moid : module.node_config_policy.0.moid
  cluster_network_policy_moid   = var.cluster_network_policy.use_existing == true ? data.intersight_hyperflex_cluster_network_policy.this.0.results.0.moid : module.cluster_network_policy.0.moid
  software_version_policy_moid  = var.software_version_policy.use_existing == true ? data.intersight_hyperflex_software_version_policy.this.0.results.0.moid : module.software_version_policy.0.moid

  ### COMMON OPTIONAL POLICIES ###
  auto_support_policy_moid      = var.auto_support_policy == null ? null : ( var.auto_support_policy.use_existing == true ? data.intersight_hyperflex_auto_support_policy.this.0.results.0.moid : module.auto_support_policy.0.moid )
  proxy_setting_policy_moid     = var.proxy_setting_policy == null ? null : ( var.proxy_setting_policy.use_existing == true ? data.intersight_hyperflex_proxy_setting_policy.this.0.results.0.moid : module.proxy_setting_policy.0.moid )

  ### VMWARE HYPERVISOR OPTIONAL POLICIES ###
  vcenter_config_policy_moid    = var.vcenter_config_policy == null ? null : ( var.vcenter_config_policy.use_existing == true ? data.intersight_hyperflex_vcenter_config_policy.this.0.results.0.moid : module.vcenter_config_policy.0.moid )
  cluster_storage_policy_moid   = var.cluster_storage_policy == null ? null : ( var.cluster_storage_policy.use_existing == true ? data.intersight_hyperflex_cluster_storage_policy.this.0.results.0.moid : module.cluster_storage_policy.0.moid )
  ### FI CONNECTED OPTIONAL ###
  ext_fc_storage_policy_moid    = var.ext_fc_storage_policy == null ? null : ( var.ext_fc_storage_policy.use_existing == true ? data.intersight_hyperflex_ext_fc_storage_policy.this.0.results.0.moid : module.ext_fc_storage_policy.0.moid )
  ext_iscsi_storage_policy_moid = var.ext_iscsi_storage_policy == null ? null : ( var.ext_iscsi_storage_policy.use_existing == true ? data.intersight_hyperflex_ext_iscsi_storage_policy.this.0.results.0.moid : module.ext_iscsi_storage_policy.0.moid )
  ucsm_config_policy_moid       = var.ucsm_config_policy == null ? null : ( var.ucsm_config_policy.use_existing == true ? data.intersight_hyperflex_ucsm_config_policy.this.0.results.0.moid : module.ucsm_config_policy.0.moid )

}
