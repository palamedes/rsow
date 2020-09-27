class DesktopController < ApplicationController

  # [GET] /
  # Load the desktop
  def index
    getBlogPostLink
  end

  # [GET] /:page[.json]
  # @TODO This will need to either work as a full page load, or a json pull of just the document
  def page
    # Okay attempt to parse the page md file based on the params
    @document = MarkdownParser::Parser.parse "page/#{params[:page]}"
    # If it's a document then cool, if not check to see if it's a blog post to catch legacy calls to content
    if @document.nil? || (@document.has_variables && !@document.published)
      # Hrmm.. is this a legacy post link?
      document = MarkdownParser::Parser.parse "post/#{params[:page]}"
      # If this is a legacy post link redirect to /blog if not, then just go to / because we cant find this
      if document.nil?
        redirect_to "/"
      else
        redirect_to "/blog/#{params[:page]}"
      end
    else

      respond_to do |format|
        format.json {
          html = render_to_string action: :page, locals: { page: params[:page] }, layout: false, formats: [:html]
          render json: {
              document: @document,
              html: html
          }
        }
        format.html {
          # Get first blog post link
          getBlogPostLink
        }
      end

    end
  end

  # [GET] /blog/:post[.json]
  # @TODO this will need to also work using a .json request for each individual part.. menu, content, tags?
  def post
    # Okay attempt to parse the page md file based on the params
    @document = MarkdownParser::Parser.parse "post/#{params[:post]}"
    # If it's a document then cool, if not route back to /
    if @document.nil? || @document.published == false
      redirect_to "/"
    else
      respond_to do |format|
        format.json {
          html = render_to_string action: :post, locals: { post: params[:post] }, layout: false, formats: [:html]
          render json: {
              document: @document,
              html: html
          }
        }
        format.html {
          # And get all posts
          @posts = MarkdownParser::Parser.posts.order_by(:date)
          # Get that blog post link for the footer.
          @blog_post_link = @posts.first.href
        }
      end
    end
  end

  # [GET] /sitemap.xml
  # We need to get a sitemap for google and others
  def sitemap
    respond_to do |format|
      format.xml {
        # Get all our posts
        @posts = MarkdownParser::Parser.posts.order_by(:date)
        # Render sitemap
        render 'sitemap.xml'
      }
    end
  end

  protected

  # Get the first blog post link and set it.
  def getBlogPostLink
    @blog_post_link = MarkdownParser::Parser.posts.order_by(:date).first.href rescue false
  end

end
