module ApplicationHelper

  # uses the redcarpet gem to render the markdown as html
  def md(markdown_in)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(markdown_in)
  end

  # render just a preview of the post -- the first paragraph that
  # gets us over 100 characters
  def show_preview(post_text)

    min_chars = 100
    max_chars = 200

    # strip out image tags for this preview
    post_text = sanitize(post_text, tags: %w(p li ol ul div span br))

    return post_text if post_text.size < min_chars

    # find the first </p> tag over min_chars chars
    # if not found by max_chars chars, stop at max_chars char
    preview_pos = post_text[min_chars..-1].index("</p>")
    num_extra_chars = min_chars + 3
    extra_chars = ""

    if preview_pos.nil? || preview_pos > max_chars
      # try looking for the first <br> tag
      preview_pos = post_text[min_chars..-1].index("<br")
      num_extra_chars = min_chars + 2
      extra_chars = ">"

      if preview_pos.nil? || preview_pos > max_chars
        # just look for the next closing tag so we don't
        # cut off an html tag in the middle
        preview_pos = post_text[min_chars..-1].index(">")
        num_extra_chars = min_chars
        extra_chars = "..."

        if preview_pos.nil? || preview_pos > max_chars
          preview_pos = max_chars
          num_extra_chars = 0
          extra_chars = "..."
        end
      end
    end
    preview = post_text[0..preview_pos+num_extra_chars]+extra_chars
    return preview
  end
end
