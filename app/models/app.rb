class App < ActiveRecord::Base
	belongs_to :author
	mount_uploader :app_icon, IconUploader
	validates :app_name, uniqueness: true

end
