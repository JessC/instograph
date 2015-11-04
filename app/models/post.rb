class Post < ActiveRecord::Base
	validates :image, presence: true

  has_attached_file :storage => :s3,
          					:s3_credentials => Proc.new{|a| a.instance.s3_credentials },
										:s3_host_name => 's3-us-west-1.amazonaws.com',
  									:image, styles: { :medium => "640x" }
  									
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  #**********************************************************************************************
     #SAYS S3 CREDENTIALS NEED TO BE IN MODEL, BUT VERIFY LATER, IF NOT DELETE!!!
     #http://stackoverflow.com/questions/19348886/rails-4-paperclip-amazon-s3-config-amazon-path 

  def s3_credentials
    {:bucket => 'instograph-content', 
     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
   	 :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    	}
  end
#**********************************************************************************************
end
