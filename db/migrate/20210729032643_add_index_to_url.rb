class AddIndexToUrl < ActiveRecord::Migration[6.1]
	def change
		add_index :urls, :token 
	end
end
