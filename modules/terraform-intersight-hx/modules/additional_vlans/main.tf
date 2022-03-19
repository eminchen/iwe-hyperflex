# {
#     "RegisteredDevice": {
#         "Moid": "623423ae6f72612d31494286",
#         "ObjectType": "asset.DeviceRegistration"
#     },
#     "Name": "test-108",
#     "Description": "Test",
#     "Mtu": 1500,
#     "Vswitch": "vm",
#     "NetworkType": "L2",
#     "Vlan": 108
# }

# # Looking up Organization MOID
# data "intersight_organization_organization" "this" {
#   name = var.organization
# }

# data "intersight_asset_device_registration" "this" {
#   ## Find assetDeviceRegistration for IWE cluster
# }

data "intersight_virtualization_iwe_cluster" "this" {
  ## Cluster Details - NOT Profile Details
  cluster_name = var.cluster_name
}

resource "intersight_virtualization_virtual_network" "this" {
  name                    = var.name
  description             = var.description # default
  infra_network           = var.infra_network # default
  mtu                     = 1500 #var.mtu # default
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

  registered_device {
    moid = "623423ae6f72612d31494286"
    #         "ObjectType": "asset.DeviceRegistration"
  }

  # cluster {
  #   moid = data.intersight_virtualization_iwe_cluster.this.moid
  # }
}
