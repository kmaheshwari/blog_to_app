class AddFieldsToApps < ActiveRecord::Migration
  def change
  	add_column :apps, :app_icon, :string
  	add_column :apps, :app_name, :string
  	add_column :apps, :featured_image, :string
  	add_column :apps, :app_url, :string
  	add_column :apps, :apk_url, :string
  	add_column :apps, :author_id, :integer
  	add_foreign_key :apps, :authors
  end
end
