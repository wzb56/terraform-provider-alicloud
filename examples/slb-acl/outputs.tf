output "slb_acl_id" {
  value = "${alicloud_slb_acl.foo.id}"
}

output "slb_acl_name" {
  value = "${alicloud_slb_acl.foo.name}"
}

output "slb_acl_ip_version" {
  value = "${alicloud_slb_acl.foo.ip_version}"
}

output "slb_acl_entrys" {
  value = "${alicloud_slb_acl.foo.entrys}"
}

output "slb_acl_related_listeners" {
  value = "${alicloud_slb_acl.foo.related_listeners}"
}
