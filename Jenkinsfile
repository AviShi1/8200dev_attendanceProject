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
                git branch: 'main', 
                url: 'https://github.com/AviShi1/8200dev_attendanceProject'
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
                DockerImage=docker.build(dockerHubRegistry + ":latest",
                    "-f ./Dockerfile .")
            }
        }
        stage('Push To DockerHub'){
            steps{
                script{
                    docker.withRegistry( '', DOCKERHUB_CREDENTIALS) {
                        DockerImage.push()
                    }
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
