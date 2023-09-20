class ChangeStatusType < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :status, :string
    change_column_default :subscriptions, :status, "Inactive"
  end
end
