require 'rails_helper'

RSpec.describe "visitors/edit", type: :view do
  before(:each) do
    @visitor = assign(:visitor, Visitor.create!(
      dni: "MyString",
      first_name: "MyString",
      last_name: "MyString",
      health: nil,
      security: nil,
      status: 1
    ))
  end

  it "renders the edit visitor form" do
    render

    assert_select "form[action=?][method=?]", visitor_path(@visitor), "post" do

      assert_select "input[name=?]", "visitor[dni]"

      assert_select "input[name=?]", "visitor[first_name]"

      assert_select "input[name=?]", "visitor[last_name]"

      assert_select "input[name=?]", "visitor[health_id]"

      assert_select "input[name=?]", "visitor[security_id]"

      assert_select "input[name=?]", "visitor[status]"
    end
  end
end
