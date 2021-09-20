pipeline {
	agent any
        triggers {
            githubPush()
        }
	stages {

		stage('Infrastructure: Create k8s cluster in AWS') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
	                               sh '''
                                                eksctl create cluster \
                                                --name cap8899 \
                                                --version 1.21 \
                                                --region us-west-2 \
                                                --nodegroup-name nginx-nodes \
                                                --node-type t2.micro \
                                                --nodes 2 \
                                                --nodes-min 1 \
                                                --nodes-max 3  \
                                                --managed
					'''
				}
			}
		}


		stage('Configurature: Create kubeconfig file of cluster') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
					sh '''
						aws eks --region us-west-2 update-kubeconfig --name cap8899
					'''
				}
			}
		}

	}
}
