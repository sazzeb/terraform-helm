resource "kubernetes_manifest" "bullboard_ingress" {
  depends_on = [helm_release.checklists]
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "bullboard-ingress"
      namespace = var.namespace
      annotations = {
        "kubernetes.io/ingress.class"                        = "nginx"
        "cert-manager.io/cluster-issuer"                     = "letsencrypt-prod"
        "nginx.ingress.kubernetes.io/force-ssl-redirect"      = "true"
        "nginx.ingress.kubernetes.io/ssl-redirect"            = "true"
      }
    }
    spec = {
      tls = [{
        hosts      = ["bullboard.outlines.info", "www.bullboard.outlines.info"]
        secretName = "bullboard-info-tls"
      }]
      rules = [{
        host = "bullboard.outlines.info"
        http = {
          paths = [{
            path     = "/"
            pathType = "Prefix"
            backend = {
              service = {
                name = "bullboard-service"
                port = {
                  number = 80
                }
              }
            }
          }]
        }
      },
        {
          host = "www.bullboard.outlines.info"
          http = {
            paths = [{
              path     = "/"
              pathType = "Prefix"
              backend = {
                service = {
                  name = "bullboard-service"
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
