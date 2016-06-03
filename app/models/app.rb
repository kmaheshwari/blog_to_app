class App < ActiveRecord::Base
	has_one :appcolour
	belongs_to :author
	mount_uploader :app_icon, IconUploader  
    has_many :appcategories
	accepts_nested_attributes_for :appcolour
    has_many :payments
    has_one :monetize
end
