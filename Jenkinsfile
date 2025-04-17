pipeline {
    agent any

    environment {
        JAR_ORIGIN = 'target/spring-boot-hello-0.0.1-SNAPSHOT.jar'
        JAR_NAME = 'myapp.jar'
        REMOTE_PATH = '/home/deploy'
        WSL_USER = 'deploy'
        WSL_IP = '172.25.55.148' // IP WSL Ubuntu
        EC2_USER = 'ec2-user'
        EC2_IP = 'ec2-x-x-x-x.compute.amazonaws.com' // Thay IP của EC2 bạn
    }

    stages {
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Pre-Deploy Checks') {
            parallel {
                stage('Run Unit Tests') {
                    steps {
                        echo 'Running unit tests...'
                        bat 'mvn test'
                    }
                }
                stage('Check Code Format') {
                    steps {
                        echo 'Checking code format...'
                        bat 'echo Code format passed (giả lập)'
                    }
                }
            }
        }

        stage('Prepare JAR') {
            steps {
                echo 'Renaming JAR...'
                bat "copy /Y ${JAR_ORIGIN} ${JAR_NAME}"
            }
        }

        stage('Deploy') {
            parallel {
                stage('Deploy to WSL') {
                    steps {
                        echo 'Deploying to WSL...'
                        bat "scp ${JAR_NAME} %WSL_USER%@%WSL_IP%:%REMOTE_PATH%"
                        bat "echo 'nohup java -jar ${JAR_NAME} > app.log 2>&1 &' > run.sh"
                        bat "scp run.sh %WSL_USER%@%WSL_IP%:%REMOTE_PATH%"
                        bat "ssh %WSL_USER%@%WSL_IP% 'cd %REMOTE_PATH% && bash run.sh'"
                    }
                }

                stage('Deploy to EC2') {
                    steps {
                        echo 'Deploying to EC2...'
                        bat "scp -i ec2.pem ${JAR_NAME} %EC2_USER%@%EC2_IP%:%REMOTE_PATH%"
                        bat "ssh -i ec2.pem %EC2_USER%@%EC2_IP% 'cd %REMOTE_PATH% && nohup java -jar ${JAR_NAME} > app.log 2>&1 &'"
                    }
                }
            }
        }
    }
}
