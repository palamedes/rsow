# Mark down parser that goes through and digs out the variables I need, scrubs the content as needed
# and passes everything back as an object for rendering.
module MarkdownParser
  # The parser class does th work of parsing an MD file.
  class Parser
    def self.parse file
      # If there is no .md add it.
      file += ".md" unless file.include? '.md'
      # Pull our template or rescue and nil
      template = File.read Rails.root.join("app/views/documents/", file) rescue nil
      # if we have our template... get to it!
      unless template.nil?
        # some Vars for the content
        document = {}
        document[:has_variables] = false
        pageContent = ''
        # What we use to know if we are working with the vars
        parsingVariables = false
        # Interate through the file line by line and get our variables
        template.lines.each_with_index do |line, index|
          # If we are at index zero and we have --- then we know we are starting our variables
          if index == 0 && line.chomp == "---"
            parsingVariables = true
            next;
            # If we don't have --- at index zero then there are no variables and just output the whole thing
          elsif index == 0 && line.chomp != "---"
            break; # There are no variables
            # If we just got a --- not at 0 and we started variables, then end variables
          elsif index != 0 && line.chomp == "---" && parsingVariables == true
            parsingVariables = false
            next;
            #End of variables.. the rest can go here.
          end
          # If we are parsing variables then do that.
          if parsingVariables == true
            document[:has_variables] = true
            # Split our line into key : value
            parsedVariable = line.split ':', 2
            # Define our key and convert it to a symbol
            key = parsedVariable.first.strip.to_sym
            # Cast as boolean if it's a boolean value
            value = parsedVariable.last.strip
            value = ActiveModel::Type::Boolean.new.cast(value) if value == 'true' || value == 'false'
            # Inject that into our pageVariables stripping white space
            document[key] = value
            # else we are parsing the rest of the page
          else
            # Do nothing with it.. at this point it must be content
            pageContent << line
          end
        end
        # Inject the HTML into the document
        document[:html] = Kramdown::Document.new(pageContent).to_html
        # Spit out our results
        return objectify(document)
      end
    end

    # Get all site tags
    def self.tags
      tags = []
      files = Dir.glob Rails.root.join('app','views','documents','post', '*')
      files.each do |filename|
        filename.gsub!(/.*\//,"post/\\1")
        document = self.parse filename
        tags << document.tags unless document.tags == ''
        # @TODO Need to handle an array correctly here
      end
      return tags.flatten.uniq
    end

    # Get all site categories
    def self.categories
      cats = []
      files = Dir.glob Rails.root.join('app','views','documents','post', '*')
      files.each do |filename|
        filename.gsub!(/.*\//,"post/\\1")
        document = self.parse filename
        cats << document.categories unless document.categories == ''
        # @TODO Need to handle an array correctly here
      end
      return cats.flatten.uniq
    end

    # Get all posts and return them with just title, exerpt, icon, and link
    def self.posts
      posts = Documents.new
      files = Dir.glob Rails.root.join('app','views','documents','post', '*')
      files.each do |filename|
        filename.gsub!(/.*\//,"post/\\1")
        document = self.parse filename
        posts << document
      end
      return posts
    end

    # Objectify the array with defaults if needed
    def self.objectify document
      return nil if document.nil?
      doc = Document.new
      doc.has_variables   = document[:has_variables]  || false
      doc.published       = document[:published]      || false
      doc.sitemap         = document[:sitemap]        || false
      doc.title           = document[:title]          || ''
      doc.excerpt         = document[:excerpt]        || ''
      doc.layout          = document[:layout]         || 'post'
      doc.tags            = document[:tags]           || ''
      doc.categories      = document[:categories]     || ''
      doc.image           = document[:image]          || ''
      doc.gallery         = document[:gallery]        || ''
      doc.ribbon          = document[:ribbon]         || ''
      doc.document_class  = document[:document_class] || ''
      doc.private         = document[:private]        || true
      doc.allow_comments  = document[:allow_comments] || false
      doc.duration        = document[:duration]       || ''
      doc.costs           = document[:costs]          || ''
      doc.slug            = document[:slug]           || ''
      doc.date            = document[:date]           || ''
      doc.icon            = document[:icon]           || ''
      doc.audio           = document[:audio]          || ''
      doc.audioautoplay   = document[:audioautoplay]  || false
      doc.audioloop       = document[:audioloop]      || false
      doc.audiovolume     = document[:audiovolume]    || 1
      doc.html            = document[:html]           || ''
      return doc
    end
    
  end

end

