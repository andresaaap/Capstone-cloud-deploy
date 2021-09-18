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
                                                --name prod \
                                                --version 1.17
                                                --nodegroup-name  linux-nodes \
                                                --node-type t2.small \
                                                --nodes 2 \
                                                --nodes-min 1 \
                                                --nodes-max 3 \
                                                --region us-west-2 \
                                                --ssh-access \
                                                --ssh-public-key udacity_CD \
                                                --managed
					'''
				}
			}
		}


		stage('Configurature: Create kubeconfig file of cluster') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
					sh '''
						aws eks --region us-west-2 update-kubeconfig --name prod
					'''
				}
			}
		}

	}
}
