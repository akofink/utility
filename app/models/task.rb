class Task < ActiveRecord::Base
  def self.by_due_date
    order(:due)
  end
end
