require 'rails_helper'

RSpec.describe "visitors/index", type: :view do
  before(:each) do
    assign(:visitors, [
      Visitor.create!(
        dni: "Dni",
        first_name: "First Name",
        last_name: "Last Name",
        health: nil,
        security: nil,
        status: 2
      ),
      Visitor.create!(
        dni: "Dni",
        first_name: "First Name",
        last_name: "Last Name",
        health: nil,
        security: nil,
        status: 2
      )
    ])
  end

  it "renders a list of visitors" do
    render
    assert_select "tr>td", text: "Dni".to_s, count: 2
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
