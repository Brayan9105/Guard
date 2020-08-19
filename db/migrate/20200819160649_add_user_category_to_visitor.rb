class AddUserCategoryToVisitor < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :user_category_id, :integer
  end
end
