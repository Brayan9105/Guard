class TokensController < ApplicationController
  def index
    @tokens = Token.all
  end

  def show
    @token = Token.find(params[:id])
    @visit = @token.visits.last
  end
end
