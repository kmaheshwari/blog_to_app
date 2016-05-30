class App < ActiveRecord::Base
	belongs_to :author

	validates :app_name, uniqueness: true , :on => :update
     
    validates_presence_of :app_name, :on => :update


	validates_presence_of :app_url 
 
    validates :app_url, uniqueness: true

	validates_presence_of :contact_email , :on => :update

    mount_uploader :app_icon, IconUploader

    has_many :appcategories
    has_many :app_pages


end
