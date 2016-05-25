class App < ActiveRecord::Base
	belongs_to :author
	mount_uploader :app_icon, IconUploader
	validates :app_name, uniqueness: true
     
     # validates :app_name, presence: true
	
	validates_presence_of :app_name

	


	  mount_uploader :app_icon, IconUploader


end
