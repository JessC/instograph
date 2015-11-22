require 'aws-sdk-v1'
require 'aws-sdk'

AWS.config(
	aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], 
	aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], 
	s3_endpoint: 's3-website-us-west-1.amazonaws.com',
	)

# AWS.config(:s3_endpoint => 's3-website-us-west-1.amazonaws.com')
#ADDED 11/20/2015
#DO I NEED THIS FILE, FIND OUT AND DELETE IF NOT