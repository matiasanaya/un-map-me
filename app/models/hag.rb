class Hag < ActiveRecord::Base
  attr_accessible :value, :product, :user

  belongs_to :user
  belongs_to :product
end
