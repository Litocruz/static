module ApplicationHelper
  #Si no encuentra un subtitulo agrega
  #uno por defecto
  def full_title (page_title)
    base_title = "SSO Manager"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
