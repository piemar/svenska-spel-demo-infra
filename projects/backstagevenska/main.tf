terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.13.1"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

# 1. Create the Project
resource "mongodbatlas_project" "project" {
  name   = var.project_name
  org_id = var.atlas_org_id
}

# 2. Create the Cluster
resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = var.cluster_name
  cluster_type = "REPLICASET"

  replication_specs {
    region_configs {
      electable_specs {
        instance_size = var.instance_size
        node_count    = 3
      }
      provider_name = "GCP"
      region_name   = var.region
      priority      = 7
    }
  }

  # Best Practice: Enable Termination Protection for production
  termination_protection_enabled = true
  
  # Best Practice: Pin Major Version
  mongo_db_major_version = "7.0"
}

# 3. Create a default Database User (Optional, for immediate access)
resource "mongodbatlas_database_user" "admin" {
  username           = "admin-user"
  password           = "ChangeMe123!" # In real scenarios, use Random Provider or Vault
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
}

# 4. Allow Access from Everywhere (Demo only - Replace with specific CIDR or Peering)
resource "mongodbatlas_project_ip_access_list" "allow_all" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Created via Backstage"
}
