require 'rails_helper'

RSpec.describe "offices/new", type: :view do
  before(:each) do
    assign(:office, Office.new(
      name: "MyString",
      floor: nil
    ))
  end

  it "renders new office form" do
    render

    assert_select "form[action=?][method=?]", offices_path, "post" do

      assert_select "input[name=?]", "office[name]"

      assert_select "input[name=?]", "office[floor_id]"
    end
  end
end
