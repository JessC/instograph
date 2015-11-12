class Post < ActiveRecord::Base
	validates :image, presence: true

  if Rails.env.production?
    has_attached_file :image, styles: { :medium => "640x" },
                      :storage => :s3,
                      :bucket => "instograph-content", 
  									  :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
  									  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                      # :path => "images/:uuid_partition/:uuid/:style.:extension",
                      # :url => ':s3_authenticated_url', # generates an expiring url
                      # :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
                      # :s3_permissions => 'private'
                      # :s3_protocol => 'https'
  else
    has_attached_file :image, styles: { :medium => "640x" },
                      :storage => :filesystem
  end  

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

# S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
