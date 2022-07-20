module "application" {
  source               = "./modules/terraform-helm/"
  deployment_name      = var.deployment_name
  deployment_namespace = var.namespace
  deployment_path      = "charts/application/"
  values_yaml          = <<EOF
replicaCount: "${var.replicaCount}"

image:
  repository: "${var.repository}"
  tag: "${var.tag}"

service:
  port: "${var.port}"

ingress:
  enabled: "${var.ingress_enabled}"
  className: "nginx"
  annotations: 
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    acme.cert-manager.io/http01-edit-in-place: "true"
    # kubernetes.io/ingress.class: nginx
  hosts:
    - host: "${var.deployment_name}-${var.namespace}.${var.google_domain_name}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: 
   - secretName: "${var.deployment_name}"
     hosts:
       - "${var.deployment_name}-${var.namespace}.${var.google_domain_name}"
  EOF
}

variable "replicaCount" {
  type        = string
  default     = 1
  description = "Please specify replicacount"
}

variable "repository" {
  type        = string
  default     = 1
  description = "Please specify repository"
}

variable "tag" {
  type        = string
  default     = 1
  description = "Please specify tag"
}

variable "port" {
  type        = string
  default     = 5000
  description = "Please specify port"
}

variable "ingress_enabled" {
  type = string
  description = "Please specify ingress_enabled"
}

variable "google_domain_name" {
  type        = string
  description = "Please specify google_domain_name"
}

variable "namespace" {
  type        = string
  description = "Please specify namespace"
}


variable "deployment_name" {
  type        = string
  description = "Please specify deployment_name"
}

