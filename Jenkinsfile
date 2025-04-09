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
                bat """
                echo Killing old Java process...
                for /f "tokens=2 delims=," %%i in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV /NH') do (
                    taskkill /PID %%i /F >nul 2>&1
                )

                echo Copying jar...
                if exist %JAR_ORIGIN% (
                    copy /Y %JAR_ORIGIN% %JAR_NAME%
                ) else (
                    echo JAR not found: %JAR_ORIGIN%
                    exit /b 1
                )

                echo Starting app...
                start /B java -jar %JAR_NAME% > %LOG_FILE% 2>&1
                """
            }
        }
    }
}
