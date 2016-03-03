#AWS.config??? docs say this but get name error...hmmm
Aws.config.update({
	region: 'us-west-1',
	credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
	})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
#S3_BUCKET = AWS::S3.new.buckets[ENV['S3_BUCKET']]

# if Rails.env == "production"
#   # set credentials from ENV hash
#   S3_CREDENTIALS = { :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
#                      :bucket => "bucket-name" }
# else
#   # get credentials from YML file
#   S3_CREDENTIALS = Rails.root.join("config/s3.yml")
# end