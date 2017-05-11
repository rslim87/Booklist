class User < ActiveRecord::Base

	has_many :books

	#ActiveRecord validations
	has_secure_password
	validates :email, :username, presence: true
	validates :email, :username, uniqueness: true

end