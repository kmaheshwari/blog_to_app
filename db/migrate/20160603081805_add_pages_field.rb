class AddPagesField < ActiveRecord::Migration
  def change
  	drop_table :app_pages
  	add_column :apps, :about_us, :string
  	add_column :apps, :privacy_policy, :string
  	add_column :apps, :app_logo, :string
  end
end
