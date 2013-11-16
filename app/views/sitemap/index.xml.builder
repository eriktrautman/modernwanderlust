xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
) do

  # Root
  xml.url do
    xml.loc "#{root_url}"
    xml.changefreq("daily")
    xml.priority(1.00)
  end

  # Blog
  xml.url do
    xml.loc "#{blog_url}"
    xml.changefreq("daily")
    xml.priority(1.00)
  end

  @posts.each do |post|
    xml.url do
      xml.loc "#{post_url(post)}"
      xml.changefreq("weekly")
      xml.priority(1.00)
      xml.lastmod post.updated_at.strftime("%F")
    end
  end
end