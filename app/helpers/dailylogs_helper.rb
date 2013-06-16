module DailylogsHelper
  def badge_class(degree)
    css_class = ["badge"]

    case
    when 1 >= degree && degree > 0.5
      css_class << "badge-important"
    when -0.5 > degree && degree >= -1.0
      css_class << "badge-info"
    end

    css_class.join(" ")
  end
end
