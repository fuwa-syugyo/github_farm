class CreateAnimals < ActiveRecord::Migration[8.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :recovery_days
      t.integer :escape_days
      t.string :image_url

      t.timestamps
    end
  end
end
