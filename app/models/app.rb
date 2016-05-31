class App < ActiveRecord::Base
	belongs_to :author

     

    has_many :appcategories
    has_many :appcolours
    has_many :app_pages

    mount_uploader :app_icon, IconUploader

    has_many :payments

end
