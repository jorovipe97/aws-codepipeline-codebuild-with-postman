# Create bucket.
aws s3 mb s3://jorovipe97-codepipeline-codebuild-with-postman

# Enable Versioning.
aws s3api put-bucket-versioning --bucket jorovipe97-codepipeline-codebuild-with-postman --versioning-configuration Status=Enabled

