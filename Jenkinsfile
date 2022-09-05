pipeline {
    environment {
        registry = "havivmuc/phpengine"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
    
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
        stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
    }
}
