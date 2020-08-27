class Visitor < ApplicationRecord
  extend FriendlyId
  friendly_id :dni, use: :slugged
  
  attribute :photo, :string, default: ''
  enum status: {available: 0, notavailable: 1}

  belongs_to :user_category
  belongs_to :security
  belongs_to :health
  has_many :visits
  has_one_attached :photo

  validates :dni, :first_name, :last_name, presence: true
  validates :dni, uniqueness: true

  def self.search(visitor_dni)
    resultQuery1 = search_by_fullname(visitor_dni)
    resultQuery2 = search_by_dni(visitor_dni)
    p '-------------- LAST RESULT -------------------'
    setting_data(resultQuery1, resultQuery2)
  end

  def self.search_by_fullname(dataQuery)
    visitors = where("first_name || ' ' || last_name ILIKE ?", "%#{dataQuery}%")
  end

  def self.search_by_dni(dataQuery)
    visitors = where("dni LIKE ?", "%#{dataQuery}%" )
  end

  def self.setting_data(query1, query2)
    result = []
    if query1.size > 0
      query1.each do |row|
        photoUrl = ""
        photoUrl = Rails.application.routes.url_helpers.rails_blob_path(row.photo, only_path: true) if row.photo.attached?
        result << {id: row.id, dni: row.dni, first_name: row.first_name, last_name: row.last_name, company: row.company ? row.company : "" ,photo: photoUrl}
      end
    end

    if query2.size > 0
      query2.each do |row|
        photoUrl = ""
        photoUrl = Rails.application.routes.url_helpers.rails_blob_path(row.photo, only_path: true) if row.photo.attached?
        result << {id: row.id, dni: row.dni, first_name: row.first_name, last_name: row.last_name, company: row.company ? row.company : "" ,photo: photoUrl}
      end
    end
    
    result
  end


end
