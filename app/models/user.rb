class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :hags
  validates_presence_of :password, :on => :create

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  private

	def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
	end
end
