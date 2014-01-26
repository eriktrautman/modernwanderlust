namespace :posts do

  desc "build the database friendly-id's for all existing posts"
  task :rebuild_friendly_ids => :environment do

    puts "Rebuilding the friendly-ids by re-saving all posts"
    Post.all.each do |post|
      post.save!
    end
  end
end