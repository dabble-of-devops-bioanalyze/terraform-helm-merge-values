locals {
  helm_values_files       = var.helm_values_files
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
     --output ${var.helm_release_merged_values_file}
    EOT
  }
}
