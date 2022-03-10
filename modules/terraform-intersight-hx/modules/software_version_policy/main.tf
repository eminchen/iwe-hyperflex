resource "intersight_hyperflex_software_version_policy" "this" {
  name                    = var.name
  description             = var.description
  server_firmware_version = var.server_firmware_version
  hypervisor_version      = var.hypervisor_version
  hxdp_version            = var.hxdp_version
}
