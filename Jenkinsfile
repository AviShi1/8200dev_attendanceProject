pipeline {
    environment{
        DOCKERHUB_CREDENTIALS=credentials('my-docker')
        dockerHubRegistry = 'avishilon22/8200dev_final'
        DockerImage=''
    }
    agent any

    stages {
        stage('Git') {
            steps {
                git branch: 'main', url: 'https://github.com/avishilon26/8200dev_attendanceProject.git'
            }
        }
        stage('Login to Docker Hub') {      	
            steps{                       	
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                		
                echo 'Login Completed'      
            }           
            
        }
        stage('Build Images'){
            steps{
                script{
                    DockerImage=docker.build(dockerHubRegistry + ":latest", "-f ./Dockerfile .")
                }
            }
            
        }
        stage('Push To DockerHub'){
            steps{
                sh 'docker push avishilon22/8200dev_final:latest'
                sh 'docker system prune --all'
                echo 'y'
            }
        }
        stage('Test'){
            steps{
                sshagent(credentials: ['ubuntu']){
                    sh 'bash -x deploy.sh test'
                }
            }
        }
        stage('Production'){
            steps{
                sshagent(credentials: ['ubuntu2']){
                    sh 'bash -x deploy.sh prod'
                }
            }
        }
        
        stage('clean up'){
            steps{
                cleanWs()
            }
        }
        
    }
}
