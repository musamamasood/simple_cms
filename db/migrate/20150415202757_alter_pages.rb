class AlterPages < ActiveRecord::Migration
  def up
  	change_column("pages", "permalink", :string, :limit => 255)
  end

  def down
  	change_column("pages", "permalink", :integar)
  end
end
