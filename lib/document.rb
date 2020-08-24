# Class document is the object returned by the parser
class Document
  attr_writer   :slug
  attr_accessor :has_variables, :file_name,
                :published, :sitemap, :title, :excerpt, :layout, :tags, :categories, :image,
                :gallery, :ribbon, :document_class, :private, :allow_comments, :duration,
                :costs, :date, :icon, :audio, :audioautoplay, :audioloop, :audiovolume,
                :html

  # Does this document have any audio?
  def has_audio?
    !audio.empty?
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

end