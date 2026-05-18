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

		stage('Deploy/Restart Container') {
			steps {
				script {
					// 1. نشيل الـ Container القديم لو موجود
					sh 'docker rm -f hivebox-container || true'
					// 2. نشغل الـ Container الجديد بالنسخة الجديدة
					sh 'docker run -d -p 50001:50001 --name hivebox-container hivebox-app'
				}
			}
		}
	}
}