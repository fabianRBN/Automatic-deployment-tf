pipeline {
    agent {
        label 'terraform'
    }

    environment {
        // Define las variables de entorno para las credenciales
        // Reemplaza 'id-de-tus-credenciales' con el ID que asignaste a tus credenciales en Jenkins
        AWS_ACCESS_KEY_ID = credentials('access_key')
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
    }

    stages {
        stage('Ejecutar Terraform') {
            steps {
                dir('Automatic-deployment-tf/enviroments/development') {
                    script {
                        // Configura las credenciales de AWS como variables de entorno
                        sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                        sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'

                        // Ejecuta Terraform
                        sh 'terraform init'
                        sh 'terraform plan'
                    }
                }
            }
        }
    }
}
