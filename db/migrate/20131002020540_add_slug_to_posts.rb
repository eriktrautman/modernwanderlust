class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string

    # since we have existing data, we need to make the column
    # for slugs unique for each post prior to adding the index
    Post.all.each do |post|
      post.slug = post.title.parameterize
      post.save!
    end

    add_index :posts, :slug, :unique => true
  end
end
