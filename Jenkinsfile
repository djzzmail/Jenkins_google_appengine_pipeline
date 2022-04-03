def jobnameparts = JOB_NAME.tokenize('/') as String[]
def jobconsolename = jobnameparts[0]
pipeline {
    environment {
        PROJECT = "vernal-tiger-346023"
	PROJECT_SECRET = "vernal-tiger-346023_secret"
        APP_NAME = "depappengine"
        CLUSTER = "jenkins-cd"
        CLUSTER_ZONE = "europe-west1-b"
        IMAGE_TAG = "eu.gcr.io/${PROJECT}/${APP_NAME}:${env.BUILD_NUMBER}"
        JENKINS_CRED = "${PROJECT}"
}
    agent {
        kubernetes {
            cloud 'gcp-ro-ci-cd-gke-cluster'
            defaultContainer 'jnlp'
            yamlFile 'build/jenkins-pod.yaml'
        }
    }
stages {
        stage(' Publish  in Google Appengine ') {
            
		steps {
		 
			
		withCredentials([file(credentialsId: "${PROJECT_SECRET}", variable: 'my_key')]) {
				
			writeFile file: "/home/jenkins/agent/workspace/${jobconsolename}/jenkins-sa-key.json", text: readFile(my_key)
			}

		    
                container('docker') {
                    script {
                        def app = docker.build("eu.gcr.io/${PROJECT}/${APP_NAME}")

                    }
                }
            }
        }	  
		  
  }
}
