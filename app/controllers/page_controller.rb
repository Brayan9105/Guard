class PageController < ApplicationController
  def dashboard
    @visits = Visit.all.order('created_at DESC').limit(5)
  end

  def three_floor
    floors = ActiveRecord::Base.connection.execute(
      "SELECT floors.name as obj, COUNT(floor_id)
      FROM visits
      INNER JOIN floors ON visits.floor_id = floors.id
      GROUP BY floors.name
      ORDER BY count DESC LIMIT 3"
    )
    render json: floors
  end

  def three_office
    offices = ActiveRecord::Base.connection.execute("
      SELECT offices.name as obj, COUNT(office_id)
      FROM visits
      INNER JOIN offices on visits.office_id = offices.id
      GROUP BY offices.name
      ORDER BY count DESC LIMIT 3
    ")
    render json: offices
  end
end
