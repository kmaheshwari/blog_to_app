class CreateGoogleAnalytics < ActiveRecord::Migration
  def change
    create_table :google_analytics do |t|
      t.string :analytics_id
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
