pipeline {
    agent any

    environment {
        API_TOKEN = credentials('my-api-token')
    }

    stages {
        stage('Use Secret') {
            steps {
                sh 'echo "Using token 1:20: $API_TOKEN"' // demo thôi, thực tế KHÔNG echo ra token!
            }
        }
    }
}
