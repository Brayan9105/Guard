class FloorsController < ApplicationController
  before_action :set_floor, only: [:show, :edit, :update, :destroy]

  def index
    @floors = Floor.all
  end

  def show
    @visits = @floor.visits.in
  end

  def new
    @floor = Floor.new
  end

  def edit
  end

  def create
    @floor = Floor.new(floor_params)
    if @floor.save
      flash[:success] = 'Se ha creado exitosamente el piso.'
      redirect_to @floor
    else
      flash.now[:danger] = 'No se ha podido crear el piso.'
      render :new
    end
  end

  def update
    if @floor.update(floor_params)
      flash[:success] = 'Se ha actualizado exitosamente el piso.' 
      redirect_to @floor
    else
      flash.now[:danger] = 'No se ha podido actualizar el piso.'
      render :edit
    end
  end

  def destroy
    @floor.destroy
    flash[:success] = 'Se ha eliminado correctamente el piso.'
    redirect_to floors_path
  end

  private
    def set_floor
      @floor = Floor.find(params[:id])
    end

    def floor_params
      params.require(:floor).permit(:name, :description)
    end
end
