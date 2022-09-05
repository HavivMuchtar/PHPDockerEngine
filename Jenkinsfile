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
                    //dockerImage = docker.build registry + ":$BUILD_NUMBER"
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
                // sh "docker-compose up -d $registry:$BUILD_NUMBER"
                step([$class: 'DockerComposeBuilder', dockerComposeFile: 'docker-compose.yml', option: [$class: 'StartService', scale: 1, service: 'php'], useCustomDockerComposeFile: false])
            }
        }
    }
}
