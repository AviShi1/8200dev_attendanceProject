pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/AviShi1/8200dev_attendanceProject.git', branch: 'main')
      }
    }

    stage('Build') {
      steps {
        sh 'docker compose build'
      }
    }

  }
}