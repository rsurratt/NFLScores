class Param < ActiveRecord::Base

  def self.week()
    Param.find_by_name('week').value
  end

end
