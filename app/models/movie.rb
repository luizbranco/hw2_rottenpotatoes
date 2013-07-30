class Movie < ActiveRecord::Base

  def self.ratings
    all.pluck(:rating).uniq
  end

end
