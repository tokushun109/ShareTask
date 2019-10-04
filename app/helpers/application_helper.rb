module ApplicationHelper
    def set_time(time)
        time.strftime("%Y/%m/%d %H:%M")
    end
end