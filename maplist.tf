locals {
  # These represent dynamic data we fetch from somewhere, such as subnet IDs and EIPs from a VPC module
  subnet_ids = ["subnet-1", "subnet-2", "subnet-3"]
  eips       = ["eip-1", "eip-2", "eip-3"]
}

resource "null_resource" "subnet_mappings" {
  count = "${length(local.subnet_ids)}"

  triggers = {
    subnet_id     = "${element(local.subnet_ids, count.index)}"
    allocation_id = "${element(local.eips, count.index)}"
  }
}


output "subnet_mappings" {
  value = "${null_resource.subnet_mappings.*.triggers}"
}
