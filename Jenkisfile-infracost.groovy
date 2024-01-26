pipeline {
    agent {
        label 'terraform'
    }

    environment {
        // Define las variables de entorno para las credenciales
        // Reemplaza 'id-de-tus-credenciales' con el ID que asignaste a tus credenciales en Jenkins
        AWS_ACCESS_KEY_ID = credentials('access_key')
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
        INFRACOST_API_KEY = credentials('INFRACOST_API_KEY')

    }

    stages {
        stage('Validate directory') {
            steps {
                sh 'pwd'
                sh 'ls -al /var/jenkins/workspace/Terraform-aws-InfraCost' 
            }
        }
        
        stage('Ejecutar Infracost') {
            steps {
        
                dir('/var/jenkins/workspace/Terraform-aws-InfraCost/environments/development') {
                    script {
                        sh 'infracost -h'
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'infracost breakdown --path /var/jenkins/workspace/Terraform-aws-InfraCost/environments/development/ > infracost-report.txt'
                        sh 'cat infracost-report.txt'
                    }
                }
            }
        }
    }
    post {
        always {
            // Archivar el reporte de Infracost
            archiveArtifacts artifacts: 'environments/development/infracost-report.txt', onlyIfSuccessful: true
        }
    }
}
