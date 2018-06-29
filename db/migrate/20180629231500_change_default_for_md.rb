class ChangeDefaultForMd < ActiveRecord::Migration[5.1]
  def up
    change_column_default :posts, :md, true
  end

  def down
    change_column_default :posts, :md, false
  end
end
