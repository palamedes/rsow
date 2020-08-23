# Class document is the object returned by the parser
class Document
  attr_accessor :published, :sitemap, :title, :excerpt, :layout, :tags, :categories, :image,
                :gallery, :ribbon, :document_class, :private, :allow_comments, :duration,
                :costs, :slug, :date, :icon, :audio, :audioautoplay, :audioloop, :audiovolume,
                :html, :has_variables

  # Does this document have any audio?
  def has_audio?
    !audio.empty?
  end

  # get the href for this document
  # @TOOD make it a FULL href?
  def href
    slug.gsub 'blog-', 'blog/'
  end

end