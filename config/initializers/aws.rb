require 'aws-sdk-v1'
require 'aws-sdk'
#or Aws.config??? docs say this but get error...hmmm
AWS.config(
	region: 'us-west-1',
	aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], 
	aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], 
	s3_endpoint: 'instograph-content.s3-website-us-west-1.amazonaws.com',
	)

#S3_BUCKET = AWS::S3.new.buckets[ENV['S3_BUCKET']]
# AWS.config(:s3_endpoint => 's3-website-us-west-1.amazonaws.com')
#ADDED 11/20/2015
#DO I NEED THIS FILE, FIND OUT AND DELETE IF NOT
# if Rails.env == "production"
#   # set credentials from ENV hash
#   S3_CREDENTIALS = { :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
#                      :bucket => "my-assets" }
# else
#   # get credentials from YML file
#   S3_CREDENTIALS = Rails.root.join("config/s3.yml")
# end