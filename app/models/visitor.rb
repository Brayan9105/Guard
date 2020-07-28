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
    visitor = where(dni: visitor_dni).first
    result = []
    if visitor
      photoUrl = ""
      photoUrl = Rails.application.routes.url_helpers.rails_blob_path(visitor.photo, only_path: true) if visitor.photo.attached?
      result[0] = {id: visitor.id, dni: visitor.dni, first_name: visitor.first_name, last_name: visitor.last_name, company: visitor.company ? visitor.company : "" ,photo: photoUrl}
    end

    result
  end
end
