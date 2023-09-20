class DropTeaSubscriptionsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :tea_subscriptions
  end
end
