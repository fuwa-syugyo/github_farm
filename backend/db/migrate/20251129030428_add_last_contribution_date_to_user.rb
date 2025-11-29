class AddLastContributionDateToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_contribution_date, :date
  end
end
