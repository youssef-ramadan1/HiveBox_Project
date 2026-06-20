resource "kubernetes_deployment" "hivebox_app" {
  metadata {
    name = "hivebox-deployment"
    labels = {
      app = "hivebox"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hivebox"
      }
    }

    template {
      metadata {
        labels = {
          app = "hivebox"
        }
      }

      spec {
        container {
          image = "hivebox_project-hivebox-app:latest" # اعدلها لاسم الـ Image بتاعتك لو مختلفة
          name  = "hivebox-container"
          image_pull_policy = "Never"

          port {
            container_port = 5001 # البورت اللي الأبليكيشن شغال عليه جوه الكود
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hivebox_service" {
  metadata {
    name = "hivebox-service"
  }

  spec {
    selector = {
      app = "hivebox"
    }

    port {
      port        = 80
      target_port = 5001
    }

    type = "ClusterIP"
  }
}