pipeline {
    agent any
    environment {
        PROJECT_ID = 'searce-playground-v1'
        CLUSTER_NAME = 'rushabh-jenkin-cluster'
        LOCATION = 'asia-south1-c'
        CREDENTIALS_ID = 'GKE'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rushabhmahale/jenkin-k8s.git']]])
            }
        }
        stage("Build image") {
            steps {
                script {
                      Img = docker.build(
                          "gcr.io/searce-playground-v1/rushabhapache:${env.BUILD_ID}",
                          "-f Dockerfile ."
                          )
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    withDockerRegistry([credentialsId: "gcr:GCR", url: "https://gcr.io"]) {
                      sh "docker push gcr.io/searce-playground-v1/rushabhapache:${env.BUILD_ID}"
                    }
                }
            }
        }
        stage('Creating Artifact'){
            steps{
                archiveArtifacts artifacts: '**', followSymlinks: false
                 }
        }
        stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/latest/${env.BUILD_ID}/g' manifest/01-deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'manifest/01-deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
	    }
     }
}
