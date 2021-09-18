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
                                                --name cap66 \
                                                --nodegroup-name  myNgroup \
                                                --node-type t2.small \
                                                --nodes 2 \
                                                --nodes-min 1 \
                                                --nodes-max 3 \  
                                                --region us-west-1 \
                                                --with-oidc \
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
						aws eks --region us-west-1 update-kubeconfig --name cap66
					'''
				}
			}
		}

	}
}
