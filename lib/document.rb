# Class document is the object returned by the parser
class Document
  attr_writer   :slug, :gallery, :image
  attr_accessor :has_variables, :file_name, :date, :updates,
                :published, :sitemap, :priority,
                :title, :excerpt, :layout, :tags, :categories,
                :ribbon, :document_class, :private, :allow_comments, :duration,
                :costs, :icon, :audio, :audioautoplay, :audioloop, :audiovolume,
                :html

  # Does this document have any audio?
  def has_audio?
    !audio.empty?
  end

  # Does this document have a gallery?
  def has_gallery?
    !gallery.empty?
  end

  # get the href for this document
  # @TOOD make it a FULL href?
  def href
    slug.gsub 'blog-', 'blog/'
  end

  # Return the file name if the slug isn't set
  def slug
    (@slug.nil? || @slug.empty?) ? @file_name.gsub(/^post\//, 'blog-').gsub(/\.md$/, '') : @slug
  end

  # Gallery maybe an array or a single item.  Act accordingly
  def gallery
    @gallery.split('|').map{|img| Site.url_for img}
  end

  # Return the image
  def image
    Site.url_for @image
  end

  # Get the full URI for this document
  def uri
    "http://www.randomstringofwords.com/#{href}"
  end

  # Get the date of the last time this document was updated (or the creation date)
  def lastmod
    allDates = @updates
    allDates << @date
    allDates.max
  end

end