pipeline {
    agent any

    environment {
        WSL_IP = '172.25.47.1' // IP của WSL Ubuntu
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
                if exist %JAR_ORIGIN% (
                    copy /Y %JAR_ORIGIN% %JAR_NAME%
                ) else (
                    echo JAR not found: %JAR_ORIGIN%
                    exit /b 1
                )
                '''
            }
        }

        stage('Deploy to WSL') {
            steps {
                bat "scp %JAR_NAME% %REMOTE_USER%@%WSL_IP%:%REMOTE_PATH%"
                bat "ssh %REMOTE_USER%@%WSL_IP% \"nohup java -jar ${REMOTE_PATH}/${JAR_NAME} > app.log 2>&1 &\""
            }
        }
    }
}
