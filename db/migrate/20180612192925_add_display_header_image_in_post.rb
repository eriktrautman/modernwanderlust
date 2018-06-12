class AddDisplayHeaderImageInPost < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :display_header_image_in_post, :boolean, :default => true

    # set each pre-existing post to actually be false
    # since I didn't use this column until this migration
    Post.all.each do |post|
      post.display_header_image_in_post = true
      post.save!
    end
  end

  def down
    remove_column :posts, :display_header_image_in_post
  end


end
