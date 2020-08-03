class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]

  def index
    @offices = Office.all
  end

  def show
    @visits = @office.visits.in
  end

  def new
    @office = Office.new
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    if @office.save
      flash[:success] = 'Se ha creado exitosamente la oficina.'
      redirect_to @office
    else
      flash.now[:danger] = 'No se ha podido crear la oficina.'
      render :new
    end
  end

  def update
    if @office.update(office_params)
      flash[:success] = 'Se ha actualizado exitosamente la oficina.'
      redirect_to @office
    else
      flash.now[:danger] = 'No se ha podido actualizar la oficina.'
      render :edit
    end
  end

  def destroy
    @office.destroy
    flash[:success] = 'Se ha eliminado correctamente la oficina.'
    redirect_to offices_path 
  end

  def floor_offices
    floor = Floor.find(params[:id])
    offices = floor.offices
    render json: offices
  end

  private
    def set_office
      @office = Office.friendly.find(params[:id])
    end

    def office_params
      params.require(:office).permit(:name, :floor_id)
    end
end
