module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def day_between range
    start_date = range.split(" - ")[0]
    end_date = range.split(" - ")[1]
    (Date.parse(end_date) - Date.parse(start_date)).to_i
  end
end
