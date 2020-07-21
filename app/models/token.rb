class Token < ApplicationRecord
  has_many :visits
  
  enum status: {enable: 0, disable: 1}
end
