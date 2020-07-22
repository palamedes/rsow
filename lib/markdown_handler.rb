# Basic markdown renderer that allows us to call .md files directly as if they were templates.
class MarkdownHandler
  def call(template)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    "#{markdown.render(template.source).inspect}.html_safe;"
  end
end