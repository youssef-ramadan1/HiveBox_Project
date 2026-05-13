pipeline {
	agent any

	stages {
		stage('Checkout') {
			steps {
				// سحب الكود من جيت هاب
				git 'https://github.com/youssef-ramadan1/HiveBox_Project.git'
			}
		}

		stage('Build Docker Image') {
			steps {
				script {
					// بناء الصورة
					sh 'docker build -t hivebox-app .'
				}
			}
		}

		stage('Security Scan (Trivy)') {
			steps {
				script {
					// دي "الزتونة": تشغيل تريفاي كحاوية مؤقتة لفحص الصورة
					sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image hivebox-app'
				}
			}
		}
	}
}