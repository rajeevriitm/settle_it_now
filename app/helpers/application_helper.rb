module ApplicationHelper
  def title_display(title="")
    base="welcome"
    if title==""
      return base
    else
      return "#{title} | #{base}"
    end
  end
  def time_of_creation(date)
    date < 24.hours.ago ? "on "+date.strftime("%m/%d/%Y") : time_ago_in_words(date) +" ago"
  end

end
