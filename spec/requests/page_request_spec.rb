require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /dashboard" do
    it "returns http success" do
      get "/page/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
