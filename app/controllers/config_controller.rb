class ConfigController < ApplicationController
  def week
    @week_param = Param.find_by_name('week')
    @week = @week_param.value
  end

  def picks
    @week = Param.week()
    @picks = Hash.new

    @a_picks = Pick.find_by_week(@week)
#    if !a_picks.nil?
#      a_picks.each { |pick|
#        @picks[pick.team] = pick.count
#      }
#    end
  end

end
