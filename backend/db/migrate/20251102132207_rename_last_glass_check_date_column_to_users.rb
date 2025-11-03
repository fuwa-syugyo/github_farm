class RenameLastGlassCheckDateColumnToUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :last_glass_check_date, :last_grass_check_date
  end
end
