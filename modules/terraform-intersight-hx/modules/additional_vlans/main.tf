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

# {
#   "module": "module.hx.module.additional_vlans[\"vm-29\"]",
#   "mode": "managed",
#   "type": "intersight_virtualization_virtual_network",
#   "name": "this",
#   "provider": "provider[\"registry.terraform.io/ciscodevnet/intersight\"]",
#   "instances": [
#     {
#       "schema_version": 0,
#       "attributes": {
#         "account_moid": "59c84e4a16267c0001c23428",
#         "additional_properties": "",
#         "ancestors": [],
#         "class_id": "virtualization.VirtualNetwork",
#         "cluster": [],
#         "create_time": "2022-03-19 06:58:04.623 +0000 UTC",
#         "description": "",
#         "discovered": false,
#         "domain_group_moid": "5b25418d7a7662743465cf72",
#         "id": "62357efb7265792d32896a19",
#         "infra_network": false,
#         "inventory": [],
#         "mod_time": "2022-03-19 06:58:04.623 +0000 UTC",
#         "moid": "62357efb7265792d32896a19",
#         "mtu": 1500,
#         "name": "LAB-29",
#         "network_type": "L2",
#         "object_type": "virtualization.VirtualNetwork",
#         "owners": [
#           "59c84e4a16267c0001c23428",
#           "623423ae6f72612d31494286"
#         ],
#         "parent": [],
#         "permission_resources": [
#           {
#             "additional_properties": "",
#             "class_id": "mo.MoRef",
#             "moid": "5ddec4226972652d33548943",
#             "object_type": "organization.Organization",
#             "selector": ""
#           }
#         ],
#         "registered_device": [
#           {
#             "additional_properties": "",
#             "class_id": "mo.MoRef",
#             "moid": "623423ae6f72612d31494286",
#             "object_type": "asset.DeviceRegistration",
#             "selector": ""
#           }
#         ],
#         "shared_scope": "",
#         "tags": [],
#         "trunk": [],
#         "version_context": [],
#         "vlan": 29,
#         "vswitch": "vm",
#         "wait_for_completion": false,
#         "workflow_info": [
#           {
#             "additional_properties": "",
#             "class_id": "mo.MoRef",
#             "moid": "62357efb696f6e2d310f6782",
#             "object_type": "workflow.WorkflowInfo",
#             "selector": ""
#           }
#         ]
#       },
#       "sensitive_attributes": [],
#       "private": "bnVsbA=="
#     }
#   ]
# },

# # Looking up Organization MOID
# data "intersight_organization_organization" "this" {
#   name = var.organization
# }

data "intersight_asset_device_registration" "this" {
  ## Find assetDeviceRegistration for IWE cluster
  platform_type = "IWE"
}

data "intersight_virtualization_iwe_cluster" "this" {
  ## Cluster Details - NOT Profile Details
  cluster_name = var.cluster_name
}

resource "intersight_virtualization_virtual_network" "this" {
  name                    = lower(var.name)
  description             = var.description # default
  infra_network           = var.infra_network # default
  mtu                     = var.mtu #var.mtu # default
  network_type            = var.network_type # default
  trunk                   = var.trunk # default
  vlan                    = var.vlan_id
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
    object_type = "asset.DeviceRegistration"
  }

  # cluster {
  #   moid = data.intersight_virtualization_iwe_cluster.this.moid
  # }
}
