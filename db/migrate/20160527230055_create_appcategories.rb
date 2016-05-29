class CreateAppcategories < ActiveRecord::Migration
  def change
  	# drop_table :appcatogries
    create_table :appcategories do |t|
      t.string :category_name
      t.integer :app_id
      t.timestamps null: false
    end
    add_foreign_key :appcategories ,:apps
  end
end
