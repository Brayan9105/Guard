class HealthsController < ApplicationController
  def index
    @healths = Health.all
  end
end
