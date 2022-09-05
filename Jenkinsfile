pipeline {
    agent any

    stages {
        stage('initws') {
            steps {
                // Clean workspace before init
                cleanWs()
                echo 'Clean workspace'
            }
        }
        stage('gitinit') {
            steps {
                echo 'git init'
                git branch: 'main', url: 'https://github.com/HavivMuchtar/PHPDockerEngine.git'
            }
        }
    }
}
