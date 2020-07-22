# Mark down parser that goes through and digs out the variables I need, scrubs the content as needed
# and passes everything back as an object for rendering.
module MarkdownParser
  class Parser
    def parse file
      # Pull our template or rescue and nil
      template = File.read Rails.root.join("app/views/documents/", file) rescue nil
      # if we have our template... get to it!
      unless template.nil?
        # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        # some Vars for the content
        pageVariables = {}
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
            # Inject that into our pageVariables stripping white space
            pageVariables[parsedVariable.first.strip] = parsedVariable.last.strip
            # else we are parsing the rest of the page
          else
            # Do nothing with it.. at this point it must be content
            pageContent << line
          end
        end

        # Spit out our results
        {
            vars: pageVariables,
            html: Kramdown::Document.new(pageContent).to_html
        }

      end
    end
  end
end
