pipeline {
  	agent none
    environment {
        GIT_BRANCH 				= 'main'
        BITBUCKET_CREDS 		= 'svc_jenkins'
        GIT_REPO_URL 			= 'https://github.com/anuradha195/express.git'
        NEXUS_CREDS 			= credentials('nexus-creds')
        QUAY_CREDS  			= credentials('quay-roboaccount-credentials')
        IMAGE_NAME 				= 'pearlthoughts-image'
        CONTAINER_NAME 			= 'pt-container'
		AWS_REGION				= 'ap-south-1'
		AWS_ACCOUNT_ID 			= '287340200978'
        TAG 					= '1.0'
		WORKSPACE 				= pwd()
		AWS_ECR_REPO_NAME		= 'pearlthoughts'
    }
	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		skipDefaultCheckout()
		disableConcurrentBuilds() 
	}
    stages {
        stage('Cleanup workspace') {
		  steps {
			cleanWs()
			dir("${env.WORKSPACE}@tmp") {
				deleteDir()
			}
			dir("${env.WORKSPACE}@script") {
				deleteDir()
			}
			dir("${env.WORKSPACE}@script@tmp") {
				deleteDir()
			}
			step([$class: 'WsCleanup'])
		  }
		}
		stage('Checkout') {
		  steps {
			script {
			  git branch: "${env.GIT_BRANCH}", credentialsId: "${env.BITBUCKET_CREDS}", url: "${env.GIT_REPO_URL}"
			}
		  }
		}
		stage('Build & Push image to AWS ECR') {
		  steps {
			script {
			  echo "Stage to build image, login and push image to AWS ECR"
			  sh ''' 
			  docker build -t ${IMAGE_NAME}:${TAG} 
			  echo "Login to AMazon ECR"
			  aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
			  echo "Tag the image appropriately"
			  docker tag ${IMAGE_NAME}:${TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${AWS_ECR_REPO_NAME}:TAG
			  echo "Push the image to Amazon ECR"
			  docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${AWS_ECR_REPO_NAME}:TAG
			  '''
			}
		  }
		}
		stage('Create AWS ECS & deploy image using Terraform') {
		  steps {
			script {
			  echo "Stage to create AWS ECS environment and deploy the above created image to ECS Fargate using terraform scripts..."
			  
			  
			}
		  }
		} 
		
	} 
}

