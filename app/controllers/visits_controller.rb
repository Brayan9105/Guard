class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  def active_visit
    @visits = Visit.all
  end

  def visit_history
    @visits = Visit.all
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

  def visit_per_day
    @visits = Visit.where("created_at = ?", params[:date])
    p @visits
  end

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:visitor_id, :floor_id, :office_id, :token_id, :in_temperature, :out_temperature, :observation)
    end
end
