# frozen_string_literal: true

module ApplicationHelper
  def set_time(time)
    time.strftime('%y/%m/%d %H時')
  end
end
