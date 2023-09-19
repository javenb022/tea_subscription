class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.string :description
      t.boolean :status
      t.float :price

      t.timestamps
    end
  end
end
