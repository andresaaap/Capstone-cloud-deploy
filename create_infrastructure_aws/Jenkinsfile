pipeline {
	agent any
	stages {

		stage('Infrastructure: Create k8s cluster in AWS') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
					sh '''
						eksctl create cluster \
						--name capstonecluster \
						--version 1.21 \
						--nodegroup-name standard-workers \
						--node-type t2.small \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 3 \
						--node-ami auto \
						--region us-west-1 \
						--zones us-west-1a \
						--zones us-west-1b \
						--zones us-west-1c \
					'''
				}
			}
		}

		

		stage('Configurature: Create config file of cluster') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
					sh '''
						aws eks --region us-west-1 update-kubeconfig --name capstonecluster
					'''
				}
			}
		}

	}
}
