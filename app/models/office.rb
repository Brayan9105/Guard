class Office < ApplicationRecord
  belongs_to :floor
  has_many :visits
  has_many :visitors, through: :visits
  
  validates :name, presence: true
end
