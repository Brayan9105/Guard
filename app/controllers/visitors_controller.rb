class VisitorsController < ApplicationController
  before_action :set_visitor, only: [:show, :edit, :update, :destroy]

  def index
    @visitors = Visitor.all
  end

  def show
  end

  def new
    @visitor = Visitor.new
  end

  def edit
  end

  def create
    @visitor = Visitor.new(visitor_params.except(:photo))
    if @visitor.save
      photo = params[:visitor][:photo].split('::')
      PictureAttachmentService.attach(@visitor, params['visitor']['photo']) unless photo[0] == "#<ActiveStorage"
      flash[:success] = 'Se ha creado exitosamente el visitante.' 
      redirect_to @visitor
    else
      flash.now[:danger] = "No se ha podido crear el visitante. #{@visitor.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def update
    if @visitor.update(visitor_params.except(:photo))
      photo = params[:visitor][:photo].split('::')
      PictureAttachmentService.attach(@visitor, params['visitor']['photo']) unless photo[0] == "#<ActiveStorage"
      flash[:success] = 'Se ha actualizado exitosamente el visitante.'
      redirect_to @visitor
    else
      flash.now[:danger] = "No se ha podido actualizar el visitante\n #{@visitor.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @visitor.destroy
    flash[:success] = 'Se ha eliminado correctamente el visitante.'
    redirect_to visitors_url
  end

  def search_visitor
    visitors = Visitor.search(params[:dni])
    render json: visitors
  end

  private
    def set_visitor
      @visitor = Visitor.find(params[:id])
    end

    def visitor_params
      params.require(:visitor).permit(:dni, :first_name, :last_name, :eps, :arl, :photo)
    end
end
