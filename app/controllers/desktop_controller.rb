class DesktopController < ApplicationController

  # [GET] /
  # Load the desktop
  def index
  end

  # [GET] /:page[.json]
  # @TODO This will need to either work as a full page load, or a json pull of just the document
  def page
    document = MarkdownParser::Parser.parse "page/#{params[:page]}"
    redirect_to "/" if document[:vars][:published] == false

    @html = document[:html].html_safe
  end

end
