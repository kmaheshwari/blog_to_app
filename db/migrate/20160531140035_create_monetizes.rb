class CreateMonetizes < ActiveRecord::Migration
  def change
    create_table :monetizes do |t|
      t.string :platform
      t.integer :phone_ad_unit
      t.string :add_unit_id
      t.integer :interval
      t.integer :app_id
      t.timestamps null: false
    end
    add_foreign_key :monetizes,:apps
  end
end
