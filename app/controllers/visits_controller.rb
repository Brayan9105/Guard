class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  def active_visit
    @visits = Visit.all.order('created_at DESC')
  end

  def visit_history
    @visits = Visit.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
  end

  def new
    @visit = Visit.new
  end

  def edit
  end

  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      token = Token.find(params[:visit][:token_id])
      token.disable!
      flash[:success] = 'Se ha registrado exitosamente la visita.'
      redirect_to active_visit_path
    else
      flash.now[:danger] = 'No se ha podido registrar la visita.'
      render :new
    end
  end

  def update
    if @visit.update(visit_params)
      token = Token.find(params[:visit][:token_id])
      token.enable!
      @visit.out!
      flash[:success] = 'Se ha dado salida al visitante de manera exitosa.'
      redirect_to active_visit_path
    else
      flash.now[:danger] = 'No se ha podido dar salida al visitante.'
      render :edit
    end
  end

  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def give_out
    @visit = Visit.find(params[:visit_id])
  end

  def search_by_date
  end

  def search_by_visitor
  end

  def search_by_floor
  end

  def visit_per_day
    if (params[:date].to_date)
      @obj = Visit.where("created_at between ? and ?", "#{params[:date].to_date} 00:00:00", "#{params[:date].to_date} 23:59:59").order("created_at DESC")
    else
      @obj = []
    end
    
    Visit.last_report(@obj)
    respond_to do |format|
      format.js { render partial: 'visits/history' }
    end
  end

  def visit_per_user
    
    if (params[:fullname].present? && params[:startDate].present? && params[:endDate].present?)
      # Todos los campos
      @obj = Visit.joins(:visitor).where("visitors.first_name || ' ' || visitors.last_name ILIKE ? AND visits.created_at BETWEEN ? AND ?", "%#{params[:fullname]}%", "#{params[:startDate].to_date} 00:00:00", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:fullname].present? && !params[:startDate].present? && !params[:endDate].present?)
      # solo el nombre
      @obj = Visit.joins(:visitor).where("visitors.first_name || ' ' || visitors.last_name ILIKE ?", "%#{params[:fullname]}%").order("created_at DESC")      
    elsif(params[:fullname].present? && params[:startDate].present?)
      # Nombre y primera fecha
      @obj = Visit.joins(:visitor).where("visitors.first_name || ' ' || visitors.last_name ILIKE ? AND visits.created_at >= ?", "%#{params[:fullname]}%", "#{params[:startDate].to_date} 00:00:00").order("created_at DESC")
    elsif(params[:fullname].present? && params[:endDate].present?)
      # Nombre y segunda fecha
      @obj = Visit.joins(:visitor).where("visitors.first_name || ' ' || visitors.last_name ILIKE ? AND visits.created_at <= ?", "%#{params[:fullname]}%", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:startDate].present? && params[:endDate].present?)
      # Dos fechas
      @obj = Visit.where("created_at BETWEEN ? and ?", "#{params[:startDate].to_date} 00:00:00", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:startDate].present?)
      # todos desde fechas
      @obj = Visit.where("created_at >= ?", "#{params[:startDate].to_date} 00:00:00").order("created_at DESC")
    elsif(params[:endDate].present?)
      # todos antes de  fechas
      @obj = Visit.where("created_at <= ?", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    else
      @obj = []
    end
    
    Visit.last_report(@obj)
    
    respond_to do |format|
      format.js { render partial: 'visits/history' }
    end
  end

  def visit_per_floor
    if (params[:startDate].present? && params[:endDate].present?)
      # Todos los campos
      @obj = Visit.joins(:floor).where("floors.id = ? AND visits.created_at BETWEEN ? AND ?", "#{params[:floor_id]}", "#{params[:startDate].to_date} 00:00:00", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(!params[:startDate].present? && !params[:endDate].present?)
      # solo el piso
      @obj = Visit.joins(:floor).where("floors.id = ?", "#{params[:floor_id]}").order("created_at DESC")      
    elsif(params[:startDate].present? && !params[:endDate].present?)
      # Nombre y primera fecha
      @obj = Visit.joins(:floor).where("floors.id = ? AND visits.created_at >= ?", "#{params[:floor_id]}", "#{params[:startDate].to_date} 00:00:00").order("created_at DESC")
    elsif(!params[:startDate].present? && params[:endDate].present?)
      # Nombre y segunda fecha
      @obj = Visit.joins(:floor).where("floors.id = ? AND visits.created_at <= ?", "#{params[:floor_id]}", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    else
      @obj = []
    end
    
    Visit.last_report(@obj)
    
    respond_to do |format|
      format.js { render partial: 'visits/history' }
    end
  end

  def visit_per_office
    if (params[:office_id].present? && params[:startDate].present? && params[:endDate].present?)
      # Todos los campos
      p '----------- TODOS LOS CAMPOS -----------'
      @obj = Visit.joins(:office).where("offices.id = ? AND visits.created_at BETWEEN ? AND ?", "#{params[:office_id]}", "#{params[:startDate].to_date} 00:00:00", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:office_id].present? && !params[:startDate].present? && !params[:endDate].present?)
      # solo el nombre
      @obj = Visit.joins(:office).where("offices.id = ?", "#{params[:office_id]}").order("created_at DESC")
    elsif(params[:office_id].present? && params[:startDate].present?)
      # Nombre y primera fecha
      @obj = Visit.joins(:office).where("offices.id = ? AND visits.created_at >= ?", "#{params[:office_id]}", "#{params[:startDate].to_date} 00:00:00").order("created_at DESC")
    elsif(params[:office_id].present? && params[:endDate].present?)
      # Nombre y segunda fecha
      @obj = Visit.joins(:office).where("offices.id = ? AND visits.created_at <= ?", "#{params[:office_id]}", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:startDate].present? && params[:endDate].present?)
      # Dos fechas
      @obj = Visit.where("created_at BETWEEN ? and ?", "#{params[:startDate].to_date} 00:00:00", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    elsif(params[:startDate].present?)
      # todos desde fechas
      @obj = Visit.where("created_at >= ?", "#{params[:startDate].to_date} 00:00:00").order("created_at DESC")
    elsif(params[:endDate].present?)
      # todos antes de  fechas
      @obj = Visit.where("created_at <= ?", "#{params[:endDate].to_date} 23:59:59").order("created_at DESC")
    else
      @obj = []
    end
    
    Visit.last_report(@obj)
    
    respond_to do |format|
      format.js { render partial: 'visits/history' }
    end
  end
  
  def get_report
    respond_to do |format|
      format.xls { send_data Visit.to_csv(col_sep: "\t")}
    end
  end

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:visitor_id, :floor_id, :office_id, :token_id, :in_temperature, :out_temperature, :observation)
    end
end
