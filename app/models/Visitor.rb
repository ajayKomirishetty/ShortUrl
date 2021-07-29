class Visitor < ActiveRecord::Base
	belongs_to :url, :foreign_key => :url_id
end