class AddColumnToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_glass_check_date, :date
    add_column :users, :image_url, :string
    rename_column :users, :github_user_id, :uid
  end
end
