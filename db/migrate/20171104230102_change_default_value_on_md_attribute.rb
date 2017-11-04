class ChangeDefaultValueOnMdAttribute < ActiveRecord::Migration[5.1]
  def up
    change_column :posts, :md, :boolean, default: false
  end

  def down
    change_column :posts, :md, :boolean, default: true
  end
end
