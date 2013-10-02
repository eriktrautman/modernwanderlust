module ApplicationHelper

  # uses the redcarpet gem to render the markdown as html
  def md(markdown_in)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(markdown_in)
  end

end
