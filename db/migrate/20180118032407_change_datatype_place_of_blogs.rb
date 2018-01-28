class ChangeDatatypePlaceOfBlogs < ActiveRecord::Migration[5.1]
  def change
    change_column :blogs, :user_id, :integer
  end
end
