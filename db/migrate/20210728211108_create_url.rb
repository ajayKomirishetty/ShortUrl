class CreateUrl < ActiveRecord::Migration[6.1]
  def change
	create_table :urls do |t|
	  t.string :link
	  t.string :token
	  t.string :tiny_url
	  t.integer :viewCount, default: 0
	  t.timestamps
	end
  end
end
