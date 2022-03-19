# # Looking up Organization MOID
# data "intersight_organization_organization" "this" {
#   name = var.organization
# }

resource "intersight_virtualization_virtual_network" "this" {
  name                    = var.name
  description             = var.description # default
  infra_network           = var.infra_network # default
  mtu                     = var.mtu # default
  network_type            = var.network_type # default
  trunk                   = var.trunk # default
  vlan                    = var.vlan
  vswitch                 = var.vswitch # default
  wait_for_completion     = var.wait_for_completion # default

  # Needed?
  # - registered_device

  # organization {
  #   # object_type = "organization.Organization"
  #   moid = data.intersight_organization_organization.this.results.0.moid
  # }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  cluster {
    moid = var.cluster_moid
  }
}
