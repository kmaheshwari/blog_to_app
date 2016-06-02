class CreateAppcolours < ActiveRecord::Migration
  def change
  
    create_table :appcolours do |t|
      t.integer  :app_id
      t.string   :top_bar_colour
      t.string   :brand_colour
      t.string   :accent_colour
      t.string   :article_colour
      t.string   :background_colour 
      t.string   :article_writer_colour 
      t.timestamps null: false
    end
        add_foreign_key :appcolours ,:apps
  end
    
end
