class AddFeedDaysToUserAnimals < ActiveRecord::Migration[8.0]
  def change
    add_column :user_animals, :feed_days, :integer, null: false, default: 0
  end
end
