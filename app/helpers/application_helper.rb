module ApplicationHelper
  def title_display(title="")
    base="welcome"
    if title==""
      return base
    else
      return "#{title} | #{base}"
    end
  end
end
