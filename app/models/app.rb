class App < ActiveRecord::Base
	belongs_to :author

	validates :app_name, uniqueness: true

	  mount_uploader :app_icon, IconUploader


end
