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
        stage('Validate directory') {
            steps {
                sh 'pwd'
                sh 'ls -al /var/jenkins/workspace/Terraform-aws-InfraCost' 
            }
        }
        stage('Install Infracost') {
            steps {
                script {
                    // Instalar Infracost
                    sh '''
                    curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
                    export PATH=$PATH:$HOME/.local/bin
                    '''
                }
            }
        }
        stage('Ejecutar Infracost') {
            steps {
        
                dir('/var/jenkins/workspace/Terraform-aws-InfraCost/environments/development') {
                    script {
                        sh '/usr/local/bin/infracost -h'
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh '/usr/local/bin/infracost breakdown --path /var/jenkins/workspace/Terraform-aws-InfraCost/environments/development/ > infracost-report.txt'
                    }
                }
            }
        }
    }
    post {
        always {
            // Archivar el reporte de Infracost
            archiveArtifacts artifacts: '/var/jenkins/workspace/Terraform-aws-InfraCost/environments/development/infracost-report.txt', onlyIfSuccessful: true
        }
    }
}
