pipeline {
	agent any
	stages {
		stage('Build') {
			steps {
				sh 'docker build -t andresaaap/cappru1:$BUILD_ID .'
			}
		}

		stage('Push') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push andresaaap/cappru1:$BUILD_ID
					'''
				}
			}
		}
	}
}