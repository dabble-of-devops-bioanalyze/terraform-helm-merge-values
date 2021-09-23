module "merge_values" {
  source = "../.."

  helm_values_files = var.helm_values_files
  helm_values_dir   = var.helm_values_dir

  context = module.this.context
}
