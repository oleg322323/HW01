class Team
  attr_reader :priorities, :task_action

  def initialize(&block)
    @devs  = [] #если в команде небудет опр. вида разработчиков
    @priorities  = []
    @task_action = {}
    instance_eval(&block)
  end

  def add_task(task)
    dev = dev_sort.slice(0)
    if dev.can_add_task?
      block = @task_action[dev.class::GROUP]
      block.call(dev, task) unless block.nil?
      dev.add_task(task)
    else
      #если нельзя добавить первому, то всем остальным тоже
      raise ArgumentError, "Вся команда занята!"
    end
  end

  def developers
    @devs.select{ |i| i.class::GROUP == :developers }
  end

  def juniors
    @devs.select{ |i| i.class::GROUP == :juniors }
  end

  def seniors
    @devs.select{ |i| i.class::GROUP == :seniors }
  end

  def all
    @devs
  end

  def report
    a = dev_sort
    
  end



  private

  def have_seniors(*names)
    names.each{ |i| @devs << SeniorDeveloper.new(i) }
  end

  def have_developers(*names)
    names.each{ |i| @devs << Developer.new(i) }
  end

  def have_juniors(*names)
    names.each{ |i| @devs << JuniorDeveloper.new(i) }
  end

  def priority(*values)
    @priorities = values
  end

  def on_task(dev_type, &block)
    @task_action[dev_type] = block
  end

  def dev_sort
    @devs.sort_by do |i|
      #модификатор опыта (джун 0, дев 1, сен 2)
      m = @priorities.find_index(i.class::GROUP)
      #приоритет, по которому отсортирует (задача = 3 пункта приоритета)
      prio = i.tasklist.count * @priorities.count + m
      #если занят, то в конец списка
      prio += 100 unless i.can_add_task?
      #сортировать по этому значению (после += плохо возвращать)
      prio
    end

    #не работает
    # @devs.sort_by do |i|
    #   [
    #     i.tasklist.count,
    #     !(i.can_add_task?),
    #     @priorities.find_index(i.class::GROUP)
    #   ]
    # end
  end
end
