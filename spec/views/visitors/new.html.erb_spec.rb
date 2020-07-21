require 'rails_helper'

RSpec.describe "visitors/new", type: :view do
  before(:each) do
    assign(:visitor, Visitor.new(
      dni: "MyString",
      first_name: "MyString",
      last_name: "MyString",
      health: nil,
      security: nil,
      status: 1
    ))
  end

  it "renders new visitor form" do
    render

    assert_select "form[action=?][method=?]", visitors_path, "post" do

      assert_select "input[name=?]", "visitor[dni]"

      assert_select "input[name=?]", "visitor[first_name]"

      assert_select "input[name=?]", "visitor[last_name]"

      assert_select "input[name=?]", "visitor[health_id]"

      assert_select "input[name=?]", "visitor[security_id]"

      assert_select "input[name=?]", "visitor[status]"
    end
  end
end
