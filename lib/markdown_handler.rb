# Basic markdown renderer that allows us to call .md files directly as if they were templates.
class MarkdownHandler
  def call(template)
    Kramdown::Document.new(template.source).to_html
  end
end