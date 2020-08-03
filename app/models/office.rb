class Office < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :floor
  has_many :visits
  has_many :visitors, through: :visits
  
  validates :name, presence: true
end
