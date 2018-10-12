output "slb_id" {
  value = "${alicloud_slb.instance.id}"
}

output "slbname" {
  value = "${alicloud_slb.instance.name}"
}

output "slb_acl_id" {
  value = "${alicloud_slb_acl.acl.id}"
}

output "slb_acl_name" {
  value = "${alicloud_slb_acl.acl.name}"
}

output "slb_acl_ip_version" {
  value = "${alicloud_slb_acl.acl.ip_version}"
}

output "slb_acl_entrys" {
  value = "${alicloud_slb_acl.acl.entrys}"
}

output "slb_acl_related_listeners" {
  value = "${alicloud_slb_acl.acl.related_listeners}"
}
