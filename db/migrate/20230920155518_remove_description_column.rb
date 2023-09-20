class RemoveDescriptionColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :description
  end
end
