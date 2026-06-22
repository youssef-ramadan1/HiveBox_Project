pipeline {
    agent any

    stages {
        stage('Push Image to K3s') {
            steps {
                script {
                    echo "شحن الـ Image جوه كونتينر الـ K3s..."
                    sh '''
                    docker save hivebox-app | docker exec -i hivebox-k3s ctr images import -
                    '''
                }
            }
        }

        stage('Deploy via Terraform') {
            steps {
                script {
                    echo "تأمين وخلق بيئة التيرام فورم والنسخ السليم..."
                    sh '''
                    docker rm -f tf-runner
                    K3S_NET=$(docker inspect hivebox-k3s -f '{{range $k,$v := .NetworkSettings.Networks}}{{$k}}{{end}}')
                    docker  run -d --name tf-runner -u root --network $K3S_NET --entrypoint sleep hashicorp/terraform:light 300
                    docker exec tf-runner mkdir -p /workspace
                    docker cp Terraform tf-runner:/workspace/

                    sed -i 's/127.0.0.1/hivebox-k3s/g' k3s-config.yaml
                    docker cp k3s-config.yaml tf-runner:/workspace/

                    docker exec -w /workspace/Terraform tf-runner terraform init
                    docker exec -w /workspace/Terraform tf-runner terraform apply -auto-approve
                    '''
                }
            }
        }
    }
}