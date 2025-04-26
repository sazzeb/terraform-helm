terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.28.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_cluster" "cluster" {
  name = "checklists"
}

provider "kubernetes" {

  config_path    = "~/.kube/config"
  config_context = "do-nyc3-checklists"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "do-nyc3-checklists"
  }
}

resource "helm_release" "checklists" {
  name             = "checklists"
  chart            = "${path.module}/chart"
  namespace        = var.namespace
  create_namespace = true

  depends_on = [
    helm_release.cert_manager,
  ]
}
