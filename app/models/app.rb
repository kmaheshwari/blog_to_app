class App < ActiveRecord::Base
	belongs_to :author
	mount_uploader :app_icon, IconUploader  
    has_many :appcategories
    has_one :appcolour
    has_many :app_pages

    
    has_many :payments
    belongs_to :monetize
end
