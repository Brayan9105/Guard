require 'rails_helper'

RSpec.describe "Securities", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/securities/index"
      expect(response).to have_http_status(:success)
    end
  end

end
