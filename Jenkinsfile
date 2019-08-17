pipeline {
	agent any
	stages {
		environment {
			IMAGE_NAME = 'cappru1'
		}
		stage('Build') {
			steps {
				sh 'docker build -t $IMAGE_NAME .'
			}
		}
	}
}