class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.integer "subject_id"
      #same as: t.reference :subject
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
    puts "*** Adding an Index in next ***"
    add_index("pages", "permalink")
    add_index("pages", "subject_id")
  end
  def down
  	drop_table :pages
  end
end
