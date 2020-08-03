class Security < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :visitor
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
