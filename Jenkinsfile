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
                    sh 'docker build -t hivebox-app .'
                }
            }
        }
        stage('Security Scan (Trivy)') {
            steps {
                script {
                    sh 'trivy image hivebox-app'
                }
            }
        }
    }
}