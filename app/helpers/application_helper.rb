module ApplicationHelper
  def title_display(title="")
    base="fuck you"
    if title==""
      return base
    else
      return "#{title} | #{base}"
    end
  end
end
