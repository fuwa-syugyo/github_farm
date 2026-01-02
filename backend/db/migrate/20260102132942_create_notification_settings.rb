class CreateNotificationSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :notification_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :notification_type
      t.boolean :enabled, default: true
      t.integer :notify_hour

      t.timestamps
    end
  end
end
