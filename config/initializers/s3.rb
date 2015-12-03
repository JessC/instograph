CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider => "AWS",
		:aws_access_key_id => 'AKIAI4YT4VOBBYXA2IBA',
		:aws_secret_access_key => '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',
		:region => 'us-west-1' #default is us-east-1...booo
	}
  config.cache_dir = "#{Rails.root}/tmp/uploads"
	config.fog_directory = ENV['S3_BUCKET']

end