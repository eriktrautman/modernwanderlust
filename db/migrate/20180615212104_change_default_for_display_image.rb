class ChangeDefaultForDisplayImage < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :display_header_image_in_post, false
  end
end
