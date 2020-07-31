class Visit < ApplicationRecord
  belongs_to :floor
  belongs_to :office
  belongs_to :token
  belongs_to :visitor
  enum status: {in: 0, out: 1}

  validates :visitor_id, :in_temperature, :floor_id, :office_id, :token_id, presence: true, on: :create

  def self.last_report(last_report)
    @last_report = last_report
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['#','Fecha', 'Cedula', 'Nombre completo', 'Piso', 'Oficina', 'Temp. Entrada', 'Temp. Salida', 'H. Entrada', 'H. Salida']
      @last_report.each_with_index do |visit, index|
         csv << [
                index + 1,
                visit.created_at.strftime("%x"),
                visit.visitor.dni,
                visit.visitor.first_name+ ' '+visit.visitor.last_name,
                visit.floor.name,
                visit.office.name,
                visit.in_temperature,
                visit.out_temperature,
                visit.created_at.in_time_zone('America/Bogota').strftime("%R %P"),
                visit.updated_at.in_time_zone('America/Bogota').strftime("%R %P")
                ]
      end
    end
  end
  # Time.now.in_time_zone('America/Bogota')
end