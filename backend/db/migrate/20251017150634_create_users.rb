class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :github_user_id
      t.integer :recovered_animal_count

      t.timestamps
    end
  end
end
