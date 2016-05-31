class App < ActiveRecord::Base
	belongs_to :author
	mount_uploader :app_icon, IconUploader  
    has_many :appcategories
    has_many :appcolours
    has_many :app_pages

    
    has_many :payments

end
