pipeline {
    agent any

    environment {
        WSL_IP = '172.25.55.148' // IP của WSL Ubuntu
        REMOTE_USER = 'deploy'
        REMOTE_PATH = '/home/deploy'
        JAR_ORIGIN = 'target/spring-boot-hello-0.0.1-SNAPSHOT.jar'
        JAR_NAME = 'myapp.jar'
    }

    stages {
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Prepare JAR') {
            steps {
                bat '''
                copy /Y "target\\spring-boot-hello-0.0.1-SNAPSHOT.jar" "myapp.jar"
                '''
            }
        }

        stage('Copy Files to WSL') {
            steps {
                bat """
                    echo nohup java -jar myapp.jar ^> app.log 2^>^&1 ^& >> run.sh
                    scp run.sh %REMOTE_USER%@%WSL_IP%:%REMOTE_PATH%
                """
            }
        }
        
          stage('Run App on WSL') {
            steps {
                bat "ssh %REMOTE_USER%@%WSL_IP% \"cd %REMOTE_PATH% && bash run.sh\""
            }
        }
    }
}
