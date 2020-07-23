require 'rails_helper'

RSpec.describe "Tokens", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/tokens/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/tokens/show"
      expect(response).to have_http_status(:success)
    end
  end

end
