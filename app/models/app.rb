class App < ActiveRecord::Base
	belongs_to :author
	# validates_presence_of :app_name, :on => :update
	# validates_presence_of :app_url 

	# validates :app_name, uniqueness: true
    # validates :app_url, uniqueness: true
     
    has_many :appcategories
    has_many :appcolours


    mount_uploader :app_icon, IconUploader

end
