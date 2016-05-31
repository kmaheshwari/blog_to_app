class App < ActiveRecord::Base
	belongs_to :author
	mount_uploader :app_icon, IconUploader
	validates :app_name, uniqueness: true
     
    validates_presence_of :app_name

	validates_presence_of :app_url

	validates_presence_of :contact_email

    mount_uploader :app_icon, IconUploader
    has_many :payments

end
