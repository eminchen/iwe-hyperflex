# Intersight HyperFlex Cluster Terraform Module

## Details
This module will simplify the configuration & deployment of a HyperFlex HCI cluster through the Intersight Cloud Operating Platform.

HyperFlex clusters are configured using a set of policies grouped together as a profile.  The profile is then assigned to a group of physical HyperFlex servers, themselves either connected and managed through a pair of Cisco UCS Fabric Interconnects (i.e. HyperFlex Data Center clusters) or connected directly to a pair of upstream switches (i.e. HyperFlex Edge clusters).
