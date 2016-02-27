class Developer
  attr_reader :name

  MAX_TASKS = 10
  PHRASE    = "выполнена задача"
  GROUP     = :developers

  def initialize(name)
    @name     = name
    @tasklist = []
  end

  def add_task(task_name)
    if @tasklist.count < self.class::MAX_TASKS
      @tasklist << task_name
      puts %Q{%s: добавлена задача "%s". Всего в списке задач: %i} %
            [@name, task_name, @tasklist.count]
    else
      raise ArgumentError, "Слишком много работы!"
    end
  end

  def tasks
    @tasklist.map.each_with_index{|val, i| "#{i+1}. #{val}"}
  end

  def work!
    raise ArgumentError, "Нечего делать!" if @tasklist.empty?
    puts %Q{%s: %s "%s". Осталось задач: %i} %
          [@name, self.class::PHRASE, @tasklist.slice!(0), @tasklist.count]
  end

  def status
    if can_work?
      can_add_task? ? ("работаю") : ("занят")
    else 
      "свободен"
    end
  end

  def can_add_task?
    @tasklist.count < self.class::MAX_TASKS
  end

  def can_work?
    @tasklist.count > 0
  end
end
