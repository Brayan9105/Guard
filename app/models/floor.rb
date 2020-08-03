class Floor < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :offices, dependent: :destroy
  has_many :visits
  has_many :visitors, through: :visits
  
  validates :name, presence: true
end
