pipeline {
	agent {
		label "ecs" // Specifies the label for the agent where this pipeline will run.
	}
	options {
		timeout(time: 1, unit: 'HOURS') // Sets a timeout for the entire pipeline to 1 hour.
	}
	environment {
		AWS_DEFAULT_REGION = "eu-west-1" // Sets the AWS region for this pipeline.
	} 
	stages {
		stage('[PROD] Get credentials') {// Defines a stage with the name 'Get credentials'.
			steps {
				script {
					AWS_CREDENTIALS_ID = "aws"// Sets the AWS credentials ID to 'aws'.
				}
			}
		}
		stage("[PROD] deploy terraform") {// Defines another stage with the name '[PROD] deploy terraform'
			steps {
				withCredentials([
					[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "$AWS_CREDENTIALS_ID"]
				]) {
					sh "make plan" // Executes a shell script called 'make plan'.
}
			}
		}
	}
}
