class CreateOrderStates < ActiveRecord::Migration
  def change
    create_table :order_states do |t|
      t.string :app_version_name
      t.string :app_status
      t.date :generated_date
      t.string :download_link
      t.integer :author_id
      t.timestamps null: false
    end
    add_foreign_key :order_states,:authors
  end
end
