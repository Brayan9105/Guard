class Token < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :visits
  
  enum status: {enable: 0, disable: 1}
end
