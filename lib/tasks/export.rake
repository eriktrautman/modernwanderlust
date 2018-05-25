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

    def clean_body(body)
      body.gsub("\n","").gsub("\r","").gsub("\t","").gsub("\u009D","")
    end

    # Prepare our CSV.
    # Render post as HTML not markdown.
    Post.order(created_at: "DESC").limit(5).each do |p|
      result << [p.id.to_s, 1.to_s, p.created_at.to_s, clean_body(p.body), p.title.to_s, p.slug.to_s, p.updated_at.to_s, p.tags.map(&:name).to_json]
    end

    csv_string = CSV.generate do |csv|
      result.each do |row|
        csv << row
      end
    end

    # all I want is for each row to print with each item as a string...
    result.each do |row|
      row.each_index do |index|
        print row[index].inspect
        print "," if index != row.size-1
      end
      print "\n"
      # print "\n"
      # puts
    end

    # byebug
    # p csv_string
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
