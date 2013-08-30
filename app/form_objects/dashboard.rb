class Dashboard
  attr_accessor :tasks

  def initialize
    @tasks = Task.by_due_date
  end
end
