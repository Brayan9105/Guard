require 'rails_helper'

RSpec.describe "offices/edit", type: :view do
  before(:each) do
    @office = assign(:office, Office.create!(
      name: "MyString",
      floor: nil
    ))
  end

  it "renders the edit office form" do
    render

    assert_select "form[action=?][method=?]", office_path(@office), "post" do

      assert_select "input[name=?]", "office[name]"

      assert_select "input[name=?]", "office[floor_id]"
    end
  end
end
