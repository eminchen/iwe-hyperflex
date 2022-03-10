### HyperFlex Profile Variables

variable "action" {
  type = string
  default = "Validate" # Validate, Deploy, Continue, Retry, Abort, Unassign

  validation {
    condition = contains(["Validate", "Deploy", "Continue", "Retry", "Abort", "Unassign"], var.action)
    error_message = "The action value must be one of Validate, Deploy, Continue, Retry, Abort or Unassign"
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
    hypervisor_type               = string ## ESXi, IWE, HyperV
    mac_address_prefix            = string
    mgmt_ip_address               = string
    mgmt_platform                 = string ## EDGE, FI
    replication                   = string
    host_name_prefix              = string
    storage_data_vlan_name        = string
    storage_data_vlan_id          = number
    storage_cluster_auxiliary_ip  = optional(string)
    storage_type                  = optional(string)
    wwxn_prefix                   = optional(string)
    ## IWE ONLY ##
    storage_client_vlan_name      = optional(string)
    storage_client_vlan_id        = optional(number)
    storage_client_ip_address     = optional(string)
    storage_client_netmask        = optional(string)
    cluster_internal_subnet       = optional(object({
      gateway                     = string
      ip_address                  = string
      netmask                     = string
      }))
    })
}
variable "local_cred_policy" {
  type = object({
    use_existing                = bool
    name                        = string
    factory_hypervisor_password = bool
    hxdp_root_pwd               = string
    hypervisor_admin            = string # admin
    hypervisor_admin_pwd        = string
  })
}

variable "sys_config_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "vcenter_config_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "cluster_storage_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "auto_support_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "node_config_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "cluster_network_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "proxy_setting_policy" {
  type = object({
    use_existing = bool
    name         = string

  })

}

variable "ext_fc_storage_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
}

variable "ext_iscsi_storage_policy" {
  type = object({
    use_existing = bool
    name         = string

  })
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
  type = object({
    use_existing = bool
    name         = string

  })
}
