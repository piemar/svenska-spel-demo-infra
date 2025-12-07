variable "atlas_org_id" {
  type        = string
  description = "MongoDB Atlas Organization ID"
}

variable "atlas_public_key" {
  type        = string
  description = "MongoDB Atlas Public API Key"
}

variable "atlas_private_key" {
  type        = string
  description = "MongoDB Atlas Private API Key"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "Name of the Atlas Project"
  default     = "backstagesvenska"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Atlas Cluster"
  default     = "backstagesvenska-cluster"
}

variable "region" {
  type        = string
  description = "GCP Region for the cluster"
  default     = "EUROPE_NORTH_1"
}

variable "instance_size" {
  type        = string
  description = "Cluster instance size (e.g., M10, M30)"
  default     = "M10"
}
