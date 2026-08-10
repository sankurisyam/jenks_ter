pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                dir('app') {
                    sh 'npm ci'
                }
            }
        }

        stage('Lint') {
            steps {
                dir('app') {
                    sh 'npm run lint'
                }
            }
        }

        stage('Build Application') {
            steps {
                dir('app') {
                    sh 'npm run build'
                }
            }
        }

        stage('Terraform Format') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check -recursive'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform init -backend=false'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform changes to AWS?', ok: 'Apply'
                dir('terraform') {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }

    post {
        success {
            echo ' Pipeline completed successfully'
        }
        failure {
            echo ' Pipeline failed'
        }
    }
}
