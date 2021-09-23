variable "helm_values_files" {
  description = "Paths to additional values files to pass into the helm install command."
  type        = list(string)
  default     = []
}

variable "helm_values_dir" {
  type        = string
  description = "Directory to store additional daskhub values files."
}
