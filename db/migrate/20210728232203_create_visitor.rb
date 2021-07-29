class CreateVisitor < ActiveRecord::Migration[6.1]
	def change
		create_table :visitors do |t|
			t.string :ip
			t.integer :url_id
			t.timestamps
		end
	end
end
