# # Looking up Organization MOID
# data "intersight_organization_organization" "this" {
#   name = var.organization
# }

# Lookup hyperflex cluster details
data "intersight_hyperflex_cluster_profile" "this" {
  moid  = var.cluster_moid
}

# Lookup compute server details
data "intersight_compute_physical_summary" "this" {
  serial  = var.serial_number
}

locals {
  # data_ip_range = data.intersight_hyperflex_cluster_profile.this.results[0].data_ip_range # not working?
  # data_ip_start_addr = regex(local.data_ip_range.start_addr

  # hxdp_data_ip = var.hxdp_data_ip == null ? (local.data_ip_range.start_addr) : var.hxdp_data_ip
}

# Create an HX node profile
resource "intersight_hyperflex_node_profile" "this" {
  name                    = var.name
  description             = var.description

  hxdp_data_ip            = var.hxdp_data_ip
  hxdp_mgmt_ip            = var.hxdp_mgmt_ip
  hxdp_storage_client_ip  = var.hxdp_storage_client_ip

  hypervisor_control_ip   = var.hypervisor_control_ip
  hypervisor_data_ip      = var.hypervisor_data_ip
  hypervisor_mgmt_ip      = var.hypervisor_mgmt_ip

  assigned_server {
    moid = data.intersight_compute_physical_summary.this.results[0].moid
    # object_type = "compute.RackUnit"
  }

  cluster_profile {
    moid = var.cluster_moid
  }
}
