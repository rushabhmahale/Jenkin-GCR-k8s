pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

	stages {
		stage('Initialize'){
        		steps {
                		def dockerHome = tool 'mydocker'
                		env.PATH = "${dockerHome}/bin:${env.PATH}"                }
        }
		stage('Build') {

			steps {
				sh 'docker build -t omkarguj30/nginx:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push omkarguj30/nginx:latest'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
