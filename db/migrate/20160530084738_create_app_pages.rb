class CreateAppPages < ActiveRecord::Migration
  def change
    create_table :app_pages do |t|
      t.string :page
      t.integer :app_id
     	
      t.timestamps null: false
    end
  end
end
