resource "random_string" "computed_values" {
  count            = length(var.helm_release_merged_values_file) == 0 ? 1 : 0
  length           = 10
  special          = false
  lower            = true
  upper            = false
  override_special = ""
}

locals {
  helm_values_files       = var.helm_values_files
  helm_release_merged_values_file = length(var.helm_release_merged_values_file) == 0 ? abspath("${var.helm_values_dir}/computed-${random_string.computed_values[0].result}-values.yaml") : var.helm_release_merged_values_file
}

resource "null_resource" "merge_yamls" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
    touch ${local.helm_release_merged_values_file}
    chmod 777 *py
    mkdir -p ${var.helm_values_dir}
    python ${path.module}/merge_yamls.py --yaml-files \
     %{for value_file in local.helm_values_files~}
        ${value_file} \
     %{endfor~}
     --output ${local.helm_release_merged_values_file}
    EOT
  }
}
