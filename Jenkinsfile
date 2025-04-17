pipeline {
    agent any

    environment {
        API_TOKEN = credentials('my-api-token')
    }

    stages {
        stage('Use Secret') {
            steps {
                bat 'echo Using token: %API_TOKEN%' // chỉ để demo, KHÔNG nên in token thật!
            }
        }
    }
}
