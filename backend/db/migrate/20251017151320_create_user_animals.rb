class CreateUserAnimals < ActiveRecord::Migration[8.0]
  def change
    create_table :user_animals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true
      t.integer :status
      t.date :start_feed_date
      t.date :last_feed_date

      t.timestamps
    end
  end
end
