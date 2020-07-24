class DesktopController < ApplicationController

  # [GET] /
  # Load the desktop
  def index
  end

  # [GET] /:page[.json]
  # @TODO This will need to either work as a full page load, or a json pull of just the document
  def page
    document = MarkdownParser::Parser.parse "page/#{params[:page]}"

    if document[:vars][:published] == false
      redirect_to "/"
    else
      @windowSlug = document[:vars][:slug].html_safe rescue nil
      @windowTitle = document[:vars][:title].html_safe
      @windowContent = document[:html].html_safe
    end

  end

end
