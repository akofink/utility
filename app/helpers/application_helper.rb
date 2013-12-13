module ApplicationHelper
  def link_back
    link_to (request.env['HTTP_REFERER'] ? :back : default) do
      "#{fa_icon 'arrow-left'} Back".html_safe
    end
  end

  def md(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      with_toc_data: true,
      tables: true,
      fenced_code_blocks: true,
      superscript: true,
      highlight: true
    ).render(text).html_safe
  end
end
