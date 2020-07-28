class PageController < ApplicationController
  def dashboard
    @visits = Visit.all.order('created_at DESC').limit(5)
  end
end
