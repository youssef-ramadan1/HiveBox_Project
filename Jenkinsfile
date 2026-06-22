pipeline {
    agent any

    stages {
       stage('Checkout') {
          steps {
             git 'https://github.com/youssef-ramadan1/HiveBox_Project.git'
          }
       }

       stage('Build Docker Image') {
          steps {
             script {
                sh 'docker build --no-cache -t hivebox-app .'
             }
          }
       }

       stage('Security Scan (Trivy)') {
          steps {
             script {
                sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image hivebox-app'
             }
          }
       }

       stage('Push Image to K3s') {
          steps {
             script {
                echo 'شحن الـ Image جوه كونتينر الـ K3s...'
                sh 'docker save hivebox-app | docker exec -i hivebox-k3s ctr images import -'
             }
          }
       }

       stage('Deploy via Terraform') {
          steps {
             script {
                echo 'تأمين وخلق بيئة التيرام فورم والنسخ السليم...'
                sh '''
                # 1. تنظيف أي بقايا قديمة لو وجدت
                docker rm -f tf-runner || true

                # 2. 🔥 الخطوة المفقودة: جلب ملف الـ kubeconfig الطازة من قلب كونتينر الـ k3s مباشرة في هذه اللحظة
                docker exec hivebox-k3s cat /etc/rancher/k3s/k3s.yaml > k3s-config.yaml

                # 3. 🔥 تعديل الـ IP جوه الملف المستخرج ليصبح اسم الكونتينر hivebox-k3s بدلاً من 127.0.0.1
                sed -i 's/127.0.0.1/hivebox-k3s/g' k3s-config.yaml

                # 4. جلب اسم شبكة الـ k3s الحالية ديناميكياً
                K3S_NET=$(docker inspect hivebox-k3s -f '{{range $k,$v := .NetworkSettings.Networks}}{{$k}}{{end}}')

                # 5. خلق الكونتينر وربطه بنفس شبكة الـ K3s
                docker run -d --name tf-runner -u root --network "$K3S_NET" --entrypoint sleep hashicorp/terraform:light 300

                # 6. عمل الفولدر المستهدف جوه الكونتينر
                docker exec tf-runner mkdir -p /workspace

                # 7. شحن فولدر الـ Terraform بالكامل  لقلب الكونتينر
                docker cp Terraform tf-runner:/workspace/

                # 8. شحن ملف الـ k3s-config.yaml "الجديد المستخرج حالا" برة الفولدر بخطوة عشان يطابق الـ (../)
                docker cp k3s-config.yaml tf-runner:/workspace/

                # 9. تدوير الـ init والـ apply بمفاتيح أصلية 100%
                docker exec -w /workspace/Terraform tf-runner terraform init
                docker exec -w /workspace/Terraform tf-runner terraform apply -auto-approve

                # 10. إبادة الكونتينر المؤقت وتنظيف البيئة
                docker rm -f tf-runner
                '''
             }
          }
       }
    }
}