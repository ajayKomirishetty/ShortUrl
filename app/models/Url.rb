class Url < ActiveRecord::Base
	validates_presence_of :link
	validates :link, format: URI::regexp(%w[http https])
	validates_length_of :link, within: 3..255, on: :create, message: "too long"      

	has_many :visitors, dependent: :destroy

  
end