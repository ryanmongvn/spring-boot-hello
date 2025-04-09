pipeline {
    agent any

    environment {
        JAR_NAME = "myapp.jar"
    }

    stages {
        stage('Build') {
            steps {
                echo '🛠 Building...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo '✅ Running tests...'
                sh 'mvn test'
            }
        }

        stage('Deploy Local') {
            steps {
                echo '🚀 Deploying locally...'
                sh """
                    pkill -f ${JAR_NAME} || true
                    cp target/*.jar ${JAR_NAME}
                    nohup java -jar ${JAR_NAME} > app.log 2>&1 &
                """
            }
        }
    }

    post {
        success {
            echo '✅ App is running locally!'
        }
        failure {
            echo '❌ Something went wrong!'
        }
    }
}
