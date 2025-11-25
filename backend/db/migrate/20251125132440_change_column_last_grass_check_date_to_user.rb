class ChangeColumnLastGrassCheckDateToUser < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :last_grass_check_date, :datetime
  end
end
