class App < ActiveRecord::Base
	belongs_to :author
	before_create :generate_access_token
	mount_uploader :app_icon, IconUploader
	validates :app_name, uniqueness: true
     
    validates_presence_of :app_name

	validates_presence_of :app_url

	validates_presence_of :contact_email

    mount_uploader :app_icon, IconUploader

    def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(access_token: random_token)
    end
  end
end
