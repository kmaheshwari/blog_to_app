class AddContactEmail < ActiveRecord::Migration
  def change
  	add_column :apps ,:contact_email ,:string
  end
end
