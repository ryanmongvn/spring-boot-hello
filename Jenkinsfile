pipeline {
    agent any

    environment {
        JAR_ORIGIN = "target\\spring-boot-hello-0.0.1-SNAPSHOT.jar"
        JAR_NAME = "myapp.jar"
        LOG_FILE = "app.log"
    }

    stages {
        stage('Build') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy Local') {
            steps {
                bat 'run-myapp.bat'
            }
        }

    }
}
