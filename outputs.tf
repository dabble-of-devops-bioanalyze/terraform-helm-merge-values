output "helm_values_merged_file" {
  description = "Merged values file"
  value       = local.helm_values_merged_file
}

output "helm_values_files" {
  description = "Listing the values file for debugging"
  value       = var.helm_values_files
}

output "helm_values_dir" {
  value = abspath(var.helm_values_dir)
}

output "merge_helm_values_files_command" {
  value = <<EOT
    chmod 777 *py
    mkdir -p ${var.helm_values_dir}
    python ${path.module}/merge_yamls.py --yaml-files \
     %{for value_file in local.helm_values_files~}
        ${value_file} \
     %{endfor~}
     --output ${local.helm_values_merged_file}
    EOT
}
