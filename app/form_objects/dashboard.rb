class Dashboard
  attr_accessor :tasks, :links

  def initialize
    @tasks = Task.by_due_date
    @links = Link.order :updated_at
  end
end
