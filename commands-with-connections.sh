# Create bucket.
aws s3 mb s3://jorovipe97-codepipeline-codebuild-with-postman

# Enable Versioning.
aws s3api put-bucket-versioning --bucket jorovipe97-codepipeline-codebuild-with-postman --versioning-configuration Status=Enabled

# Save the Postman collection file in S3 using the AWS CLI
aws s3 cp 02postman/PetStoreAPI.postman_collection.json \
	s3://jorovipe97-codepipeline-codebuild-with-postman/postman-env-files/PetStoreAPI.postman_collection.json

# Save the Postman environment file to S3 using the AWS CLI
aws s3 cp 02postman/PetStoreAPIEnvironment.postman_environment.json \
	s3://jorovipe97-codepipeline-codebuild-with-postman/postman-env-files/PetStoreAPIEnvironment.postman_environment.json

# Use the AWS CLI to deploy the AWS CloudFormation template as follows
# aws cloudformation create-stack --stack-name petstore-api-pipeline \
# 	--template-body file://./petstore-api-pipeline.yaml \
# 	--parameters \
# 		ParameterKey=BucketRoot,ParameterValue=jorovipe97-codepipeline-codebuild-with-postman \
# 		ParameterKey=GitHubBranch,ParameterValue=master \
# 		ParameterKey=GitHubRepositoryName,ParameterValue=aws-codepipeline-codebuild-with-postman \
# 		ParameterKey=GitHubToken,ParameterValue=<REPLACE_ME_GITHUB_TOKEN> \
# 		ParameterKey=GitHubUser,ParameterValue=jorovipe97 \
# 	--capabilities CAPABILITY_NAMED_IAM

# Create jorovipe97-github-connection stack.
aws cloudformation create-stack --stack-name jorovipe97-github-connection \
	--template-body file://./github-connection.yaml \
	--parameters \
		ParameterKey=ConnectionName,ParameterValue=jorovipe97-connection

# Update jorovipe97-github-connection stack.
aws cloudformation update-stack --stack-name jorovipe97-github-connection \
	--template-body file://./github-connection.yaml \
	--parameters \
		ParameterKey=ConnectionName,ParameterValue=jorovipe97-connection

# Create petstore-api-pipeline stack.
aws cloudformation create-stack --stack-name petstore-api-pipeline \
	--template-body file://./petstore-api-pipeline.yaml \
	--parameters \
		ParameterKey=BucketRoot,ParameterValue=jorovipe97-codepipeline-codebuild-with-postman \
		ParameterKey=GitHubBranch,ParameterValue=master \
		ParameterKey=GitHubRepositoryName,ParameterValue=aws-codepipeline-codebuild-with-postman \
		ParameterKey=GitHubUser,ParameterValue=jorovipe97 \
		ParameterKey=GithubConnection,ParameterValue=jorovipe97-github-connection:jorovipe97-connection \
	--capabilities CAPABILITY_NAMED_IAM

# Update petstore-api-pipeline stack.
aws cloudformation update-stack --stack-name petstore-api-pipeline \
	--template-body file://./petstore-api-pipeline.yaml \
	--parameters \
		ParameterKey=BucketRoot,ParameterValue=jorovipe97-codepipeline-codebuild-with-postman \
		ParameterKey=GitHubBranch,ParameterValue=master \
		ParameterKey=GitHubRepositoryName,ParameterValue=aws-codepipeline-codebuild-with-postman \
		ParameterKey=GitHubUser,ParameterValue=jorovipe97 \
		ParameterKey=GithubConnection,ParameterValue=jorovipe97-github-connection:jorovipe97-connection \
	--capabilities CAPABILITY_NAMED_IAM
