class Pick < ActiveRecord::Base
  def self.picks_hash(week)
    picks = Hash.new(0)
    Pick.where("week = #{week}").each { |pick|
      picks[pick.team] = pick.count
    }
    picks
  end
end
