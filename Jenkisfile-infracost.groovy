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
        stage('VAlidate directory') {
            steps {
                sh 'pwd'
                sh 'ls -al /var/jenkins/workspace/Terraform-aws' 
            }
        }
        stage('Ejecutar Infracost') {
            steps {
        
                dir('/var/jenkins/workspace/Terraform-aws/environments/development') {
                    script {
                        sh 'infracost breakdown --path main.tf > infracost-report.txt'
                    }
                }
            }
        }
    }
    post {
        always {
            // Archivar el reporte de Infracost
            archiveArtifacts artifacts: '/var/jenkins/workspace/Terraform-aws/environments/development/infracost-report.txt', onlyIfSuccessful: true
        }
    }
}