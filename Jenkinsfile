properties([pipelineTriggers([githubPush()])])

pipeline {
    environment {
        registry = "havivmuc/phpengine"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
    
    agent any

    stages {
        stage('Clean workspace') {
            steps {
                // Clean workspace before init
                cleanWs()
                echo 'Clean workspace'
            }
        }
        stage('Checkout SCM') {
            steps {
                checkout([
                 $class: 'GitSCM',
                 branches: [[name: 'main']],
                 userRemoteConfigs: [[
                    url: 'https://github.com/HavivMuchtar/PHPDockerEngine.git',
                    credentialsId: 'github_id2',
                 ]]
                ])
            }
        }
        stage('Git init') {
            steps {
                echo 'git init'
                git branch: 'main', url: 'https://github.com/HavivMuchtar/PHPDockerEngine.git'
            }
        }
        stage('Building the image') {
            steps {
                script {
                    dockerImage = docker.build( registry + ":latest", "-t " + registry + ":v.$BUILD_NUMBER .")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run the image with Docker Compose') {
            steps {
                step([$class: 'DockerComposeBuilder', dockerComposeFile: 'docker-compose.yml', option: [$class: 'StartService', scale: 1, service: 'php'], useCustomDockerComposeFile: false])
            }
        }
    }
}
