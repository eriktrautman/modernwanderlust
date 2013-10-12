module ApplicationHelper

  # uses the redcarpet gem to render the markdown as html
  def md(markdown_in)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(markdown_in)
  end

  # render just a preview of the post -- the first paragraph that
  # gets us over 100 characters
  def show_preview(post_text)

    return post_text if post_text.size < 500

    # find the first </p> tag over 500 chars
    # if not found by 1000 chars, stop at 1000th char
    preview_pos = post_text[500..-1].index("</p>")
    num_extra_chars = 503
    extra_chars = ""
    puts "\n\n\n\n <p>!"

    if preview_pos.nil? || preview_pos > 1000
      # try looking for the first <br> tag
      preview_pos = post_text[500..-1].index("<br")
      num_extra_chars = 502
      extra_chars = ">"
      puts "<br>!"
      
      if preview_pos.nil? || preview_pos > 1000
        # just look for the next closing tag so we don't
        # cut off an html tag in the middle
        preview_pos = post_text[500..-1].index(">")
        num_extra_chars = 500
        extra_chars = "..."
        puts ">!"

        if preview_pos.nil?
          preview_pos = 500
          num_extra_chars = 0
          extra_chars = "..."
          puts "last resort..."
        end
      end
    end
    puts "finished with pos #{preview_pos}, num #{num_extra_chars}, and extrachars #{extra_chars}!\n\n\n"
    preview = post_text[0..preview_pos+num_extra_chars]+extra_chars
    puts "...and preview of: #{preview}!!!!!!!!\n\n\n\n"
    return preview
  end
end
