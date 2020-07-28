class Visit < ApplicationRecord
  belongs_to :floor
  belongs_to :office
  belongs_to :token
  belongs_to :visitor
  enum status: {in: 0, out: 1}

  validates :visitor_id, :in_temperature, :floor_id, :office_id, :token_id, presence: true, on: :create

  # Time.now.in_time_zone('America/Bogota')
end