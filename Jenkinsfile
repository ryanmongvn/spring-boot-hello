pipeline {
    agent any

    environment {
        JAR_NAME = "myapp.jar"
    }

    stages {
        stage('Build') {
            steps {
                echo '🛠 Building...'
                bat 'mvn clean package -DskipTests'
            }
        }

        // stage('Test') {
        //     steps {
        //         echo '✅ Running tests...'
        //         bat 'mvn test'
        //     }
        // }

        stage('Deploy Local') {
            steps {
                echo '🚀 Deploying locally...'
                bat """
                    for /f "tokens=2 delims==;" %%i in ('wmic process where "commandline like '%%${JAR_NAME}%%'" get ProcessId /value') do taskkill /PID %%i /F
                    copy target\spring-boot-hello-0.0.1-SNAPSHOT.jar ${JAR_NAME}
                    start java -jar ${JAR_NAME} > app.log 2>&1
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
