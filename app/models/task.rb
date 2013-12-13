class Task < ActiveRecord::Base
  belongs_to :user

  def self.by_due_date
    order(:status, :due, :title)
  end
end
