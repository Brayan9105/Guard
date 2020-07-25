class SecuritiesController < ApplicationController
  before_action :set_security, only: [:edit, :update]
  
  def new
    @security = Security.new()
  end

  def create
    @security = Security.new(security_params)
    if @security.save
      flash[:success] = 'Se ha creado exitosamente la arl.'
      redirect_to securities_path
    else
      flash.now[:danger] = 'No se ha podido crear la arl.'
      render :new
    end
  end

  def edit
  end

  def update
    if @security.update(security_params)
      flash[:success] = 'Se ha actualizado exitosamente la arl.'
      redirect_to securities_path
    else
      flash.now[:danger] = 'No se ha podido actualizar la arl.'
      render :edit
    end
  end

  def index
    @securities = Security.all
  end

  private
  def set_security
    @security = Security.find(params[:id])
  end

  def security_params
    params.require(:security).permit(:name, :address, :phone)
  end
end
