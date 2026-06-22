terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }
}

provider "kubernetes" {
  # مسار ملف الـ config اللي جينكنز بنسخه للـ runner
  config_path = "../k3s-config.yaml"

  # السطر السحري اللي هيتخطى حماية الـ TLS والشهادات عشان نربط بالـ كونتير الموضعي سليم
  insecure = true
}