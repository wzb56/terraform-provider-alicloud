---
layout: "alicloud"
page_title: "Alicloud: alicloud_slb_acl"
sidebar_current: "docs-alicloud-resource-slb-acl"
description: |-
  Provides a Load Banlancer Access Control List resource.
---

# alicloud\_slb\_acl

A access control list contains multiple IP addresses or CIDR blocks.
The access control list can help you to define multiple instance listening dimension,
and to meet the multiple usage for single access control list.

Server Load Balancer allows you to configure access control for listeners.
You can configure different whitelists or blacklists for different listeners.

You can configure access control
when you create a listener or change access control configuration after a listener is created.


~> **NOTE:** One access control list can be attached with multiple Listener in different load balancer as whitelists or blacklists.
~> **NOTE:** The maximum number of access control lists per region  is 50.
~> **NOTE:** The maximum number of IP addresses added each time is 50.
~> **NOTE:** The maximum number of entries per access control list is 300.
~> **NOTE:** The maximum number of listeners that an access control list can be added to is 50.

## Example Usage

```
   # Create a new access control list

   resource "alicloud_slb_acl" "foo" {
     name = "tf-testAccSlbAcl"
     ip_version = "ipv4"
     entrys = [
       {
         entry="10.10.10.0/24"
         comment="first-a"
       },
       {
         entry="168.10.10.0/24"
         comment="abc-test-abc-b"
       },
     ]
   }

```

```
# Create a new access control list and attach it to different (tcp/udp/http) listeners.
resource "alicloud_slb" "instance" {
  name = "${var.slb_name}"
  internet_charge_type = "${var.internet_charge_type}"
  internet = "${var.internet}"
}

resource "alicloud_slb_listener" "tcp" {
  load_balancer_id = "${alicloud_slb.instance.id}"
  backend_port = "22"
  frontend_port = "22"
  protocol = "tcp"
  bandwidth = "10"
  health_check_type = "tcp"
  persistence_timeout = 3600
  healthy_threshold = 8
  unhealthy_threshold = 8
  health_check_timeout = 8
  health_check_interval = 5
  health_check_http_code = "http_2xx"
  health_check_timeout = 8
  health_check_connect_port = 20
  health_check_uri = "/console"
  acl_status = "on"
  acl_type   = "black"
  acl_id     = "${alicloud_slb_acl.acl.id}"

}

resource "alicloud_slb_listener" "udp" {
  load_balancer_id = "${alicloud_slb.instance.id}"
  backend_port = 2001
  frontend_port = 2001
  protocol = "udp"
  bandwidth = 10
  persistence_timeout = 3600
  healthy_threshold = 8
  unhealthy_threshold = 8
  health_check_timeout = 8
  health_check_interval = 4
  health_check_timeout = 8
  health_check_connect_port = 20
  acl_status = "on"
  acl_type   = "black"
  acl_id     = "${alicloud_slb_acl.acl.id}"
}

resource "alicloud_slb_listener" "http" {
  load_balancer_id = "${alicloud_slb.instance.id}"
  backend_port = 80
  frontend_port = 80
  protocol = "http"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "testslblistenercookie"
  cookie_timeout = 86400
  health_check = "on"
  health_check_uri = "/cons"
  health_check_connect_port = 20
  healthy_threshold = 8
  unhealthy_threshold = 8
  health_check_timeout = 8
  health_check_interval = 5
  health_check_http_code = "http_2xx,http_3xx"
  bandwidth = 10
  acl_status = "on"
  acl_type   = "white"
  acl_id     = "${alicloud_slb_acl.acl.id}"
}

resource "alicloud_slb_acl" "acl" {
  name = "tf-slb-acl-related-listeners-x"
  ip_version = "ipv4"
   entrys = [
    {
      entry="10.10.10.0/24"
      comment="first"
    },
    {
      entry="168.10.10.0/24"
      comment="second"
    },
    {
      entry="172.10.10.0/24"
      comment="third"
    },
    {
      entry="128.10.10.0/24"
      comment="third"
    },
  ]
}
```

## Argument Reference

The following arguments are supported:
* `name` - (Required) Name of the access control list.
* `ip_version` - (Optional, ForceNew) The IP Version of access control list is the type of its entry (IP addresses or CIDR blocks). It values ipv4/ipv6. Our plugin provides a default ip_version: "ipv4".
* `entrys` - (Optional) A list of entry (IP addresses or CIDR blocks) to be added. At most 50 etnry can be supported in one resource. It contains two sub-fields as `Entry Block` follows.

## Entry Block

The entry mapping supports the following:
* `entry` - (Required) An IP addresses or CIDR blocks.
* `comment` - (Optional) the comment of the entry.

## Attributes Reference

The following attributes are exported:
* `name` - The Name of the access control list.
* `ip_version` - The IP Version of the access control list.
* `entrys` - A list of entry (IP addresses or CIDR blocks) that have be added.

## Import

Load balancer access control list can be imported using the id, e.g.

```
$ terraform import alicloud_slb_acl.example abc123456
```
