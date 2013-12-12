module ApplicationHelper
  def link_back
    link_to request.env['HTTP_REFERER'] ? :back : default do
      "#{fa_icon 'arrow-left'} Back".html_safe
    end
  end
end
