module DatesHelper
  def format_date(date_string)
    Date.parse(date_string).strftime("%d.%m.%y")
  end
end
