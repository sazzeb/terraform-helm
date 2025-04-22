terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8"
    }
  }
}

provider "helm" {
  kubernetes {
    # point Helm at your kubeconfig
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "checklist" {
  name             = "checklist"
  chart            = "${path.module}/chart"
  namespace        = "checklist"
  create_namespace = true        # <-- let Helm create it
}
