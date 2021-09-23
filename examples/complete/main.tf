module "merge_values" {
  # source = "dabble-of-devops-biodeploy/merge-values/helm"
  source = "../.."

  helm_values_files = var.helm_values_files
  helm_values_dir   = var.helm_values_dir

  context = module.this.context
}
