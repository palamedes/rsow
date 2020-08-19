# Class document is the object returned by the parser
class Document
  attr_accessor :published, :sitemap, :title, :excerpt, :layout, :tags, :categories, :image,
                :gallery, :ribbon, :document_class, :private, :allow_comments, :duration,
                :costs, :slug, :date, :icon, :audio, :audioautoplay, :audioloop, :audiovolume,
                :html

  # Does this document have any audio?
  def has_audio?
    !audio.nil?
  end


  def order_by key

  end

end