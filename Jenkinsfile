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
            withCredentials([
                [$class: 'AmazonWebServicesCredentialsBinding',
                 credentialsId: 'terraform-aws']
            ]) {
                sh '''
                    terraform init

                    terraform import module.iam.aws_iam_user.image_app image-app-user || true

                    terraform import module.s3.aws_s3_bucket.images imagevault-dev-images-5302 || true

                    terraform import module.iam.aws_iam_policy.image_upload arn:aws:iam::447356678470:policy/image-upload || true

                    terraform plan -out=tfplan
                '''
            }
        }
    }
}

        stage('Terraform Apply') {
            steps {
                dir('terraform/environment/dev') {
                    input message: 'Apply this Terraform plan to AWS?', ok: 'Apply'

                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'terraform-aws']]) {
                        sh '''
                            aws sts get-caller-identity
                            terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully '
        }

        failure {
            echo 'Pipeline failed'
        }
    }
}