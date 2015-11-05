class Post < ActiveRecord::Base
	validates :image, presence: true

  has_attached_file :image, styles: { :medium => "640x" },
  									:storage => :s3,
  									:bucket => "elasticbeanstalk-us-west-1-467246738516", 
  									:access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
  									:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  									
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

# S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
