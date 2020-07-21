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
    respond_to do |format|
      if @visit.save
        token = Token.find(params[:visit][:token_id])
        token.disable!
        format.html { redirect_to active_visit_path, notice: 'Visit was successfully created.' }
        format.json { render :show, status: :created, location: @visit }
      else
        format.html { render :new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @visit.update(visit_params)
        token = Token.find(params[:visit][:token_id])
        token.enable!
        @visit.out!
        format.html { redirect_to active_visit_path, notice: 'Visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { render :edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
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

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.require(:visit).permit(:visitor_id, :floor_id, :office_id, :token_id, :in_temperature, :out_temperature)
    end
end
