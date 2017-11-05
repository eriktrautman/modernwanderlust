class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    url: '/ckeditor_assets/pictures/:id/:style_:basename.:extension',
                    # path: ':rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension',
                    # Styles guide:
                    # No trailing means it proportionally resizes so no dimensions
                    #    exceed the specified boundaries.  So '400x400' on a panoramic
                    #    1200x300 image would be reduced to 400x100.
                    # trailing # means will be centrally cropped to get dimensions
                    # trailing > means will only reduce images if larger than this (ignores smaller)
                    # trailing < means will only enlarge smaller images (ignore bigger)
                    # Can do % resizing too.
                    # General convention: WIDTH x HEIGHT
                    # For WAY more, see http://www.imagemagick.org/Usage/resize/
                    styles: {
                        content: '800>',      # The default used in the post
                        contentlg: '1600>',
                        thumb: '118x100#',    # used in the file browser window
                        square: '400x400#',
                        squarelg: '800x800#',
                        banner: '720x240#',
                        # 'original' is always present and uncropped.
                    }

  # One problem: Right now we're assuming all files get displayed as the same size
  #   (800px max dimension).  That's okay for blog posts but NOT okay for large
  #   photo displays.  But CKEditor's code only calls `.url_content` (to get the
  #   "content" size) for the image browser.  So there isn't any way to access the
  #   alternative sizes (eg the original) other than to manually alter the URL to
  #   reflect that size's name, eg /squarelg/.

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 25.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end
