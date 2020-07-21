require 'rails_helper'

RSpec.describe "visits/index", type: :view do
  before(:each) do
    assign(:visits, [
      Visit.create!(
        in_temperature: 2,
        out_temperature: 3,
        status: 4,
        visitor: nil,
        floor: nil,
        office: nil,
        token: nil
      ),
      Visit.create!(
        in_temperature: 2,
        out_temperature: 3,
        status: 4,
        visitor: nil,
        floor: nil,
        office: nil,
        token: nil
      )
    ])
  end

  it "renders a list of visits" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
