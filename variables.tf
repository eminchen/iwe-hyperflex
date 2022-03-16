### Intersight - Common Variables

variable "intersight_key" {
  type = string
}

variable "intersight_secret" {
  type = string
}

variable "intersight_url" {
  type = string
  default = "https://intersight.com"
}

### HyperFlex Profile Variables

variable "action" {
  type = string
  default = "Validate" # Validate, Deploy, Continue, Retry, Abort, Unassign

  validation {
    condition = contains(["Validate", "Deploy", "Continue", "Retry", "Abort", "Unassign"], var.action)
    error_message = "The action value must be one of Validate, Deploy, Continue, Retry, Abort or Unassign."
  }
}

variable "wait_for_completion" {
  type = bool
  default = false
}

variable "tags" {
  type    = list(map(string))
  default = []
}

variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}

variable "cluster" {
  type = object({
    name                          = string
    description                   = string
    data_ip_address               = string
    hypervisor_control_ip_address = string
    hypervisor_type               = string ## ESXi, IWE, HyperV
    mac_address_prefix            = string
    mgmt_ip_address               = string
    mgmt_platform                 = string ## EDGE, FI
    replication                   = number
    host_name_prefix              = string
    storage_data_vlan             = object({
      name    = string
      vlan_id = number
      })
    storage_cluster_auxiliary_ip  = optional(string)
    storage_type                  = optional(string)
    wwxn_prefix                   = optional(string)
    ## IWE ONLY ##
    storage_client_vlan = object({
      name       = string
      vlan_id    = number
      ip_address = string
      netmask    = string
      })
    cluster_internal_subnet       = optional(object({
      gateway                     = string
      ip_address                  = string
      netmask                     = string
      }))
    })
}

variable "local_cred_policy" {
  # type = object({
  #   use_existing                = bool
  #   name                        = string
  #   factory_hypervisor_password = bool
  #   hxdp_root_pwd               = string
  #   hypervisor_admin            = string # admin
  #   hypervisor_admin_pwd        = string
  # })
}

variable "sys_config_policy" {
  # type = object({
  #   use_existing    = bool
  #   name            = string
  #   description     = string
  #   dns_domain_name = string
  #   dns_servers     = list(string)
  #   ntp_servers     = list(string)
  #   timezone        = string
  # })
}

variable "vcenter_config_policy" {
  # type = object({
  #   use_existing  = bool
  #   name          = string
  #   description   = string
  #   data_center   = string
  #   hostname      = string
  #   password      = string
  #   sso_url       = optional(string)
  #   username      = string
  # })
}

variable "cluster_storage_policy" {
  # type = object({
  #   use_existing            = bool
  #   name                    = string
  #   description             = string
  #   kvm_ip_range            = object({
  #     end_addr              = string
  #     gateway               = string
  #     netmask               = string
  #     start_addr            = string
  #     })
  #   server_firmware_version = string
  # })
}

variable "auto_support_policy" {
  # type = object({
  #   use_existing              = bool
  #   name                      = string
  #   description               = string
  #   admin_state               = bool
  #   service_ticket_receipient = string
  #
  # })
}

variable "node_config_policy" {
  # type = object({
  #   use_existing = bool
  #   name         = string
  #   description = string
  #   node_name_prefix = string
  #   data_ip_range = object({
  #     end_addr    = string
  #     gateway     = string
  #     netmask     = string
  #     start_addr  = string
  #     })
  #   hxdp_ip_range = object({
  #     end_addr    = string
  #     gateway     = string
  #     netmask     = string
  #     start_addr  = string
  #     })
  #   hypervisor_control_ip_range = object({
  #     end_addr    = string
  #     gateway     = string
  #     netmask     = string
  #     start_addr  = string
  #     })
  #   mgmt_ip_range = object({
  #     end_addr    = string
  #     gateway     = string
  #     netmask     = string
  #     start_addr  = string
  #     })
  # })
}

variable "cluster_network_policy" {
  # type = object({
  #   use_existing = bool
  #   name         = string
  #   description  = string
  #   jumbo_frame  = bool
  #   mac_prefix_range = object({
  #     end_addr   = string
  #     start_addr = string
  #     })
  #   mgmt_vlan = object({
  #     name    = string
  #     vlan_id = number
  #     })
  #   uplink_speed = string
  #   vm_migration_vlan = object({
  #     name    = string
  #     vlan_id = number
  #     })
  #   vm_network_vlans = list(object({
  #     name    = string
  #     vlan_id = number
  #     }))
  # })
}

variable "proxy_setting_policy" {
  # type = object({
  #   use_existing  = bool
  #   name          = string
  #   description   = string
  #   hostname      = string
  #   password      = string
  #   port          = number
  #   username      = string
  # })
}

variable "ext_fc_storage_policy" {
  # type = object({
  #   use_existing = bool
  #   name         = string
  #   description = string
  #   admin_state = bool
  #   exta_traffic = object({
  #     name    = string
  #     vsan_id = number
  #     })
  #   extb_traffic = object({
  #     name    = string
  #     vsan_id = number
  #     })
  #   wwxn_prefix_range = object({
  #     end_addr   = string
  #     start_addr = string
  #     })
  # })
}

variable "ext_iscsi_storage_policy" {
  # type = object({
  #   use_existing = bool
  #   name         = string
  #   description = string
  #   admin_state = bool
  #   exta_traffic = object({
  #     name    = string
  #     vlan_id = number
  #     })
  #   extb_traffic = object({
  #     name    = string
  #     vlan_id = number
  #     })
  # })
}

variable "software_version_policy" {
  type = object({
    use_existing            = bool
    name                    = string
    description             = string
    server_firmware_version = string
    hypervisor_version      = string
    hxdp_version            = string
  })
}

variable "ucsm_config_policy" {
  # type = object({
  #   use_existing  = bool
  #   name          = string
  #   description   = string
  #   kvm_ip_range = object({
  #     end_addr    = string
  #     gateway     = string
  #     netmask     = string
  #     start_addr  = string
  #     })
  #   server_firmware_version = string
  # })
}
