class CreateSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
        t.string "name", :limit => 50
        t.integer "position", :null => false
        t.boolean "visible", :default => true
        t.timestamps null: false
    end
  	puts "*** Adding an Index in next ***"
    add_index("subjects", "name")
  end
  def down
    	drop_table :subjects
  end
end
