require 'rails_helper'

RSpec.describe "visitors/show", type: :view do
  before(:each) do
    @visitor = assign(:visitor, Visitor.create!(
      dni: "Dni",
      first_name: "First Name",
      last_name: "Last Name",
      health: nil,
      security: nil,
      status: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Dni/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
