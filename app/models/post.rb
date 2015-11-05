class Post < ActiveRecord::Base
	validates :image, presence: true

  has_attached_file :image, 
  									:storage => s3,
  									:s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  									styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def s3_credentials
    {:bucket => "elasticbeanstalk-us-west-1-467246738516", :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end

end