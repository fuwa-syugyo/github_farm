class ChangeColumnFromUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :uid, false
    change_column_null :users, :name, false
    change_column_null :users, :recovered_animal_count, false
    change_column_default :users, :recovered_animal_count, from: nil, to: 0

    add_index :users, :uid, unique: true
  end
end
