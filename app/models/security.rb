class Security < ApplicationRecord
  has_many :visitor
  
  validates :name, presence: true
  validates :name, uniqueness: true
end
