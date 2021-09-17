pipeline {
	agent any
	stages {

		stage('Infrastructure: Create k8s cluster in AWS') {
			steps {
				withAWS(region:'us-west-1', credentials:'aws_credential') {
					sh '''
						eksctl create cluster \
						--name NginxCluster \
						--version 1.21 \
						--nodegroup-name myNgroup \
						--node-type t2.micro \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 3 \
                                                --ssh-access \
                                                --managed false \
                                                --region us-west-1 \
                                                --ssh-public-key udacity_CD
				
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
