class Addheaderimagetoposts < ActiveRecord::Migration[5.1]
  def up
    add_attachment :posts, :header_image
  end

  def down
    remove_attachment :posts, :header_image
  end

end
