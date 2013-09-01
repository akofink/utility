class Task < ActiveRecord::Base
  def self.by_due_date
    order(:status, :due, :title)
  end
end
