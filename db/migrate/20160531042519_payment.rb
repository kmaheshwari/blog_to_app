class Payment < ActiveRecord::Migration
  def change
  	create_table :payments do |t|
  		t.string :customer_id
  		t.integer :app_id
  		t.float :amount
  		t.string :status
      t.timestamps null: false
    end
    add_foreign_key :payments,:apps
  end
end
