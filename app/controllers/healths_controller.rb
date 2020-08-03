class HealthsController < ApplicationController
  before_action :set_health, only: [:edit, :update]
  
  def new
    @health = Health.new()
  end

  def create
    @health = Health.new(health_params)
    if @health.save
      flash[:success] = 'Se ha creado exitosamente la eps.'
      redirect_to healths_path
    else
      flash.now[:danger] = 'No se ha podido crear la eps.'
      render :new
    end
  end

  def edit
  end

  def update
    if @health.update(health_params)
      flash[:success] = 'Se ha actualizado exitosamente la eps.'
      redirect_to healths_path
    else
      flash.now[:danger] = 'No se ha podido actualizar la eps.'
      render :edit
    end
  end

  def index
    @healths = Health.all
  end

  private
  def set_health
    @health = Health.friendly.find(params[:id])
  end

  def health_params
    params.require(:health).permit(:name, :address, :phone)
  end
end
