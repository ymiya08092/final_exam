class AddImageToPicturesAndUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :image, :text
    add_column :users, :image, :text
  end
end
