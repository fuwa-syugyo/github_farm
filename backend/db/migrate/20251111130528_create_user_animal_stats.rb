class CreateUserAnimalStats < ActiveRecord::Migration[8.0]
  def change
    create_table :user_animal_stats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true
      t.integer :recovered_count, default: 0, null: false

      t.timestamps
    end

    add_index :user_animal_stats, [:user_id, :animal_id], unique: true
  end
end
