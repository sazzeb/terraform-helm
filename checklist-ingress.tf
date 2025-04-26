resource "kubernetes_manifest" "outlines_ingress" {
  depends_on = [helm_release.checklists]
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "outlines-info-ingress"
      namespace = var.namespace
      annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
        "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      }
    }
    spec = {
      tls = [{
        hosts      = ["outlines.info", "www.outlines.info"]
        secretName = "outlines-info-tls"
      }]
      rules = [{
        host = "outlines.info"
        http = {
          paths = [{
            path     = "/"
            pathType = "Prefix"
            backend = {
              service = {
                name = "checklist-service"
                port = {
                  number = 80
                }
              }
            }
          }]
        }
      },
        {
          host = "www.outlines.info"
          http = {
            paths = [{
              path     = "/"
              pathType = "Prefix"
              backend = {
                service = {
                  name = "checklist-service"
                  port = {
                    number = 80
                  }
                }
              }
            }]
          }
        }]
    }
  }
}
