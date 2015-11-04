class User < ActiveRecord::Base

	has_many :pictures
  has_one :profile

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates_uniqueness_of :email
  validates_uniqueness_of :username

   #**********************************************************************************************
     #SAYS S3 CREDENTIALS NEED TO BE IN MODEL, BUT VERIFY LATER, IF NOT DELETE!!!
     #http://stackoverflow.com/questions/19348886/rails-4-paperclip-amazon-s3-config-amazon-path 
  #  has_attached_file :download,
  #         :storage => :s3,
  #         :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
		# 			:s3_host_name => 's3-us-west-1.amazonaws.com'
  # def s3_credentials
  #   {:bucket => '###################', 
  #    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  #  	 :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  #   	}
  # end
#**********************************************************************************************
end
