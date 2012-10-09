class Session < ActiveRecord::Base
  attr_accessible :session_id

  def self.sweep_inactive( time = 1.hour )
    time = time.split.inject { |count, unit|
      count.to_i.send(unit)
    } if time.is_a?(String)

    self.delete_all('updated_at < ?', time.ago )
  end

  def self.sweep_too_long( time = 1.day )
    time = time.split.inject { |count, unit|
      count.to_i.send(unit)
    } if time.is_a?(String)

    self.delete_all('create_at < ?', time.ago )
  end
end
