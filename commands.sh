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
aws cloudformation create-stack --stack-name petstore-api-pipeline \
	--template-body file://./petstore-api-pipeline.yaml \
	--parameters \
		ParameterKey=BucketRoot,ParameterValue=<REPLACE_ME_WITH_UNIQUE_BUCKET_NAME> \
		ParameterKey=GitHubBranch,ParameterValue=<REPLACE_ME_GITHUB_BRANCH> \
		ParameterKey=GitHubRepositoryName,ParameterValue=<REPLACE_ME_GITHUB_REPO> \
		ParameterKey=GitHubToken,ParameterValue=<REPLACE_ME_GITHUB_TOKEN> \
		ParameterKey=GitHubUser,ParameterValue=<REPLACE_ME_GITHUB_USERNAME> \
	--capabilities CAPABILITY_NAMED_IAM