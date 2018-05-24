namespace :posts do

  desc "export posts in a wordpress-friendly format"
  task :export_for_wp => :environment do

    # Kill unnecessary logging
    loglevel = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 1


    require 'csv'
    result = []

    # Initialize with the headers
    headers = ["id","post_author","post_date","post_content","post_title","post_name","post_modified","post_category"]
    result << headers

    # Prepare our CSV
    Post.limit(3).each do |p|
      result << [p.id, 1, p.created_at, p.body, p.title, p.slug, p.updated_at, p.tags.map(&:name)]
    end

    result.each do |row|
      puts row.join(",")
    end

    ActiveRecord::Base.logger.level = loglevel
    # puts "Creating CSV"
    #
    # CSV.open('test_file.csv','w', headers:true) do |csv_obj|
    #   csv_obj << headers
    #   posts.each do |row|
    #     csv_obj << row
    #   end
    # end

    # puts "All done!"

  end
end
