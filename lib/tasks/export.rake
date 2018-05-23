namespace :posts do

  desc "export posts in a wordpress-friendly format"
  task :export_for_wp => :environment do

    puts "Let's do this!!!"

    require 'csv'

    # Initialize with the headers
    headers = ["id","post_author","post_date","post_content","post_title","post_name","post_modified","post_category"]

    # Prepare our CSV
    posts = Post.limit(1).map do |p|
      [p.id, 1, p.created_at, p.body, p.title, p.slug, p.updated_at, p.tags.map(&:name)]
    end

    puts "Creating CSV"

    CSV.open('test_file.csv','w', headers:true) do |csv_obj|
      csv_obj << headers
      posts.each do |row|
        csv_obj << row
      end
    end

    puts "All done!"

  end
end
