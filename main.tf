resource "null_resource" "merge_yamls" {
  provisioner "local-exec" {
    command = <<EOT
    touch ${var.helm_release_merged_values_file}
    chmod 777 *py
    mkdir -p ${var.helm_values_dir}
    python ${path.module}/merge_yamls.py --yaml-files \
     %{for value_file in var.helm_values_files~}
        ${value_file} \
     %{endfor~}
     --output ${var.helm_release_merged_values_file}
    EOT
  }
}
