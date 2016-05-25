class App < ActiveRecord::Base
	belongs_to :author

	validates :app_name, uniqueness: true
     
     # validates :app_name, presence: true
	
	validates_presence_of :app_name

	


	  mount_uploader :app_icon, IconUploader


end
