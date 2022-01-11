resource "helm_release" "nginx" {
  name        = "nginx-ingress-controller"
  chart       = "nginx-ingress-controller"
  repository  = "https://charts.bitnami.com/bitnami"
  namespace   = "nginx"
  max_history = 3
  create_namespace = true
  wait             = true
  reset_values     = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
