class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.string :address, :null => false
      t.float :latitude
      t.float :longitude
      t.string :category
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
