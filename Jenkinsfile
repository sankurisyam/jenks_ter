pipeline {
    agent any

    tools {
        nodejs 'node22'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
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
                dir('terraform/environment/dev') {
                    sh '''
                        terraform init -backend=false
                        terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform/environment/dev') {
                    sh '''
                        terraform init
                        terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform/environment/dev') {
                    input message: 'Apply this Terraform plan to AWS?', ok: 'Apply'

                    sh '''
                        terraform apply tfplan
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }

        failure {
            echo 'Pipeline failed'
        }
    }
}