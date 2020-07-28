# Mark down parser that goes through and digs out the variables I need, scrubs the content as needed
# and passes everything back as an object for rendering.
module MarkdownParser
  class Parser
    def self.parse file
      # If there is no .md add it.
      file += ".md" unless file.include? '.md'
      # Pull our template or rescue and nil
      template = File.read Rails.root.join("app/views/documents/", file) rescue nil
      # if we have our template... get to it!
      unless template.nil?
        # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        # some Vars for the content
        document = {}
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
        return document
      end
    end
  end
end

# @TODO Create a Document Object to pass around.. too much formatting needs to happen as it is.
