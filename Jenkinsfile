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

		stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						kubectl config use-context arn:aws:eks:us-east-2:560967782130:cluster/esktest
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
				withAWS(region:'us-east-2', credentials:'aws-static') {
					sh '''
						kubectl expose deployment blueimage --type=LoadBalancer --port=80
					'''
				}
			}
		}

		stage('Domain redirect blue') {
			steps {
				withAWS(region:'us-east-2', credentials:'aws-static') {
					sh '''
						aws route53 change-resource-record-sets --hosted-zone-id Z04130201VBQBX5OMRR0P --change-batch file://alias-record.json
					'''
				}
			}
		}
	}
}
