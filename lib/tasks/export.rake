namespace :posts do

  desc "export posts in a wordpress-friendly format"
  task :export_for_wp => :environment do

    # Kill unnecessary logging
    loglevel = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 4


    require 'csv'
    result = []

    # Initialize with the headers
    headers = ["id","post_author","post_date","post_content","post_title","post_name","post_modified","post_category"]
    result << headers

    # Reproduce our basic markdown renderer
    def md(markdown_in)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      markdown.render(markdown_in)
    end

    # Prepare our CSV.
    # Render post as HTML not markdown.
    Post.limit(1).each do |p|
      result << [p.id, 1, p.created_at, md(p.body), p.title, p.slug, p.updated_at, p.tags.map(&:name)]
    end

    puts result.to_csv
    # result.each do |row|
    #   puts row.join(",")
    # end

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
