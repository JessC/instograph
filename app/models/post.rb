class Post < ActiveRecord::Base
	mount_uploader :image, ImageUploader#, :mount_on => :image

  # validates :image, presence: true

 # if Rails.env.test?
 #    has_attached_file :image, styles: { :medium => "640x" },
 #    :storage => :filesystem 
 # else
 #    has_attached_file :image, styles: { :medium => "640x" },
 #    :bucket => ENV['S3_BUCKET'], 
 #    :storage => :fog,
 #    :region => 'us-west-1',
 #    :s3_endpoint => 'https://instograph-content.s3.amazonaws.com/',
 #    :access_key_id => ENV["AWS_ACCESS_KEY_ID"], 
 #    :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
 #  # :path => "images/:uuid_partition/:uuid/:style.:extension",
 #  # :url => ':s3_authenticated_url', # generates an expiring url
 #  # :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
 #  # :s3_permissions => 'private'
 #  # :s3_protocol => 'https'
  
 # end  

 #  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

