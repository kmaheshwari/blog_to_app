class CreateAppDrafts < ActiveRecord::Migration
  def change
    create_table :app_drafts do |t|
      t.string   "app_icon"
      t.string   "app_name"
      t.string   "categories"
      t.string   "about_us"
      t.string   "privacy_policy"
      t.string  "top_bar_colour"
      t.string   "contact_email"
      t.string   "brand_colour"
      t.string   "article_colour"
      t.string   "accent_colour"
      t.string   "article_writer_colour"
      t.integer  "author_id"
      t.integer  "app_id"
      t.timestamps null: false
    end
  end
end
