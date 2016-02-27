class Team
  attr_reader :developers, :juniors, :seniors, :priorities, :task_action

  def initialize(&block)
    @developers  = [] #если в команде небудет опр. вида разработчиков
    @juniors     = []
    @seniors     = []
    @priorities  = []
    @task_action = {}
    instance_eval(&block)
  end

  def add_task(task)

  end

  private

  def have_seniors(*names)
    # @seniors = names
    names.each{|i| @seniors << SeniorDeveloper.new(i)}
  end

  def have_developers(*names)
    # @developers = names
    names.each{|i| @developers << Developer.new(i)}
  end

  def have_juniors(*names)
    # @juniors = names
    names.each{|i| @juniors << JuniorDeveloper.new(i)}
  end

  def priority(*values)
    @priorities = values
  end

  def on_task(dev_type, &block)
    @task_action[dev_type] = block
  end

  def task_count
end
