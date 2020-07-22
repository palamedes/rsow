# Inject the ability to render .md views directly.
require Rails.root.join("lib", "markdown_handler")

ActionView::Template.register_template_handler(:md, MarkdownHandler.new)