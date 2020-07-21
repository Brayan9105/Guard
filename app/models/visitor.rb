class Visitor < ApplicationRecord
  attribute :photo, :string, default: ''
  enum status: {available: 0, notavailable: 1}

  belongs_to :security
  belongs_to :health
  has_many :visits
  has_one_attached :photo

  validates :dni, :first_name, :last_name, :health_id, :security_id, presence: true
  validates :dni, uniqueness: true

  def self.search(visitor_dni)
    visitor_dni = visitor_dni.strip
    result = ActiveRecord::Base.connection.execute("select id, dni, first_name, last_name from visitors where dni = '#{visitor_dni}'").to_a
    p '------------'
    p result
    result
  end
end
