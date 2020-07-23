class SecuritiesController < ApplicationController
  def index
    @securities = Security.all
  end
end
