pipeline {
	agent any
	stages {
		stage('Lint HTML') {
			steps {
				sh 'tidy -q -e *.html'
			}
		}
		
		stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker build -t davincizhao/testcapstone:$BUILD_ID .
					'''
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push davincizhao/testcapstone:$BUILD_ID
					'''
				}
			}
		}
		stage('create EKS cluster') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						aws eks create-cluster --name project7 \
						--role-arn arn:aws:iam::560967782130:user/jenkins \
						--resources-vpc-config subnetIds=subnet-0fc96d2cbfef62c9f,subnet-036426cab82d12cbd,subnet-067acf82983b0b457,securityGroupIds=sg-068da0085656483b4 
					
					'''
				}
			}
		}		

		stage('Set kubeconfig') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						aws --region us-east-2 eks update-kubeconfig --name project7 --role-arn arn:aws:iam::560967782130:user/jenkins
					
					'''
				}
			}
		}
		stage('test config') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						kubectl get svc 
					
					'''
				}
			}
		}		

		stage('Create blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						kubectl run blueimage --image=davincizhao/testcapstone:$BUILD_ID --port=80
					'''
				}
			}
		}

		stage('Expose container') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						kubectl expose deployment blueimage --type=LoadBalancer --port=80
					'''
				}
			}
		}

		stage('Domain redirect blue') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						aws route53 change-resource-record-sets --hosted-zone-id Z04130201VBQBX5OMRR0P --change-batch file://alias-record.json
					'''
				}
			}
		}
	}
}
