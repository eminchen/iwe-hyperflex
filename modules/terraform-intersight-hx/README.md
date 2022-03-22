# Intersight HyperFlex Cluster Terraform Module

## Details
This module will simplify the configuration & deployment of a HyperFlex HCI cluster through the Intersight Cloud Operating Platform.

HyperFlex clusters are configured using a set of policies grouped together as a profile.  The profile is then assigned to a group of physical HyperFlex servers, themselves either connected and managed through a pair of Cisco UCS Fabric Interconnects (i.e. HyperFlex Data Center clusters) or connected directly any upstream switches (i.e. HyperFlex Edge clusters).  This module will support either connectivity model.

This module will suport deploying HyperFlex clusters with eithe the default VMware vSphere ESXi operating system, or now the Cisco Intersight Workload Engine operating system for Kubernetes workloads. There are some configuration differences between these two operating systems.  Please see the section for each OS below.


## Caveats
* The Intersight Terraform provider tracks the `action` parameter as a stateful configuration parameter however Interisght will change this parameter to `No-op` after the action has been submitted.  This will mean any subsequent runs will show the `action` parameter as not matching the state and Terraform will attempt to redeploy the cluster.  This should have no impact however.
* `wait_for_completion = true` and `action = deploy` will cause Terraform to wait until the deployment has completed.  For HX deployments, this may take longer than the default timeout of 2 hours so this combination is not recommended.
