class Dashboard < ActiveRecord::Base
  attr_accessor :tasks, :links, :user

  def initialize(args = {})
    @tasks = args[:tasks] || Task.by_due_date
    @links = args[:links] || Link.order('LOWER(content)')
  end

  def self.find(user_id)
    user = User.find user_id
    Dashboard.new user: user,
      tasks: user.tasks.by_due_date,
      links: user.links.order('LOWER(content)')
  end
end
