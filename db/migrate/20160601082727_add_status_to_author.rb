class AddStatusToAuthor < ActiveRecord::Migration
  def change

  	add_column :authors,:author_active , :boolean, :default => false


  end
end


