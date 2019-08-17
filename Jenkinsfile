pipeline {
	agent any
	stages {
		stage('Build') {
			steps {
				sh 'docker build -t cappru1":$BUILD_NUMBER" .'
			}
		}

		stage('Push') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh 'echo "hello"'
				}
			}
		}
	}
}