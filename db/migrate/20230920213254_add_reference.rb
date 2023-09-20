class AddReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :tea, foreign_key: true
  end
end
