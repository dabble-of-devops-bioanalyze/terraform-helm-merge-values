resource "random_string" "computed_values" {
  length           = 10
  special          = false
  lower            = true
  upper            = false
  override_special = ""
}

locals {
  helm_values_files       = var.helm_values_files
  helm_values_merged_file = abspath("${var.helm_values_dir}/computed-${random_string.computed_values.result}-values.yaml")
}

resource "null_resource" "merge_yamls" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
    chmod 777 *py
    mkdir -p ${var.helm_values_dir}
    python ${path.module}/merge_yamls.py --yaml-files \
     %{for value_file in local.helm_values_files~}
        ${value_file} \
     %{endfor~}
     --output ${local.helm_values_merged_file}
    EOT
  }
}
