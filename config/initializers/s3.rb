CarrierWave.configure do |config|
	# config.fog_provider = 'fog/aws' 
	config.fog_credentials = {
		provider:               'AWS',
		aws_access_key_id:      'AKIAI4YT4VOBBYXA2IBA',
		aws_secret_access_key:  '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',
		region:                 'us-west-1' #default is us-east-1...booo
	}
	config.fog_directory =  'instograph-content'
  # config.cache_dir =      "#{Rails.root}/tmp/uploads"

end

# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     aws_access_key_id:     'xxx',                        # required
#     aws_secret_access_key: 'yyy',                        # required
#     region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
#     host:                  's3.example.com',             # optional, defaults to nil
#     endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
#   }
#   config.fog_directory  = 'name_of_directory'                          # required
#   config.fog_public     = false                                        # optional, defaults to true
#   config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
# end


