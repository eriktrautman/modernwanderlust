class AddMdToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :md, :boolean, :default => true

    # set each pre-existing post to actually be false
    # since I didn't use .md until this migration
    Post.all.each do |post|
      post.md = false
      post.save!
    end

  end
end
