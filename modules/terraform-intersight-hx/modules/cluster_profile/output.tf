output "moid" {
  value = intersight_hyperflex_cluster_profile.this.moid
}

output "nodes" {
  value = data.intersight_hyperflex_node.nodes
}
