# Intersight HyperFlex Cluster Terraform Module

## Introduction
This module will simplify the configuration & deployment of a HyperFlex HCI cluster through the Intersight Cloud Operating Platform.

HyperFlex clusters are configured using a set of policies grouped together as a profile.  The profile is then assigned to a group of physical HyperFlex servers, themselves either connected and managed through a pair of Cisco UCS Fabric Interconnects (i.e. **HyperFlex Data Center** clusters) or connected directly any upstream switches (i.e. **HyperFlex Edge** clusters).  This module will support either connectivity model.

This module will suport deploying HyperFlex clusters with either the default *VMware vSphere ESXi* operating system, or now the *[Cisco Intersight Workload Engine (IWE)](https://www.cisco.com/c/en/us/products/collateral/cloud-systems-management/intersight/at-a-glance-c45-2470301.html)* operating system for Kubernetes workloads. There are some configuration differences between these two operating systems.  Please see the section for each OS below.

## Usage

### VMware vSphere ESXi Operating System

```hcl


```

### Cisco Intersight Workload Engine Operating System

## Caveats
* The Intersight Terraform provider tracks the `action` parameter as a stateful configuration parameter however Interisght will change this parameter to `No-op` after the action has been submitted.  This will mean any subsequent runs will show the `action` parameter as not matching the state and Terraform will attempt to redeploy the cluster.  This should have no impact however as Intersight will verify nothing has changed.  To avoid this being seen as a state change in Terraform, set the `action` parameter to `No-op`.

![tfcb plan no-op to deploy](./images/no-op-deploy.png)

![tfcb plan no-op to deploy intersight view](./images/no-op-deploy2.png)

* `wait_for_completion = true` and `action = deploy` will cause Terraform to wait until the deployment has completed.  For HX deployments, this may take longer than the default timeout of 2 hours so this combination is not recommended.  

![tfcb apply failed](./images/apply-failed.png)

* For IWE deployments, adding VM network VLANs requires the cluster to have been deployed first then the plan run and applied a 2nd time, but with the variable `cluster_deployed` set to `true`. Also the `action` parameter is not applicable to adding (or removing) additional VLANs.
