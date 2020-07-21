require 'rails_helper'

RSpec.describe "visits/edit", type: :view do
  before(:each) do
    @visit = assign(:visit, Visit.create!(
      in_temperature: 1,
      out_temperature: 1,
      status: 1,
      visitor: nil,
      floor: nil,
      office: nil,
      token: nil
    ))
  end

  it "renders the edit visit form" do
    render

    assert_select "form[action=?][method=?]", visit_path(@visit), "post" do

      assert_select "input[name=?]", "visit[in_temperature]"

      assert_select "input[name=?]", "visit[out_temperature]"

      assert_select "input[name=?]", "visit[status]"

      assert_select "input[name=?]", "visit[visitor_id]"

      assert_select "input[name=?]", "visit[floor_id]"

      assert_select "input[name=?]", "visit[office_id]"

      assert_select "input[name=?]", "visit[token_id]"
    end
  end
end
