class Developer
  MAX_TASKS = 10
  PHRASE    = "выполнена задача"

  def initialize(name)
    @name     = name
    @tasklist = []
  end

  def add_task(task_name)
    begin
      if @tasklist.count < self.class::MAX_TASKS
        @tasklist << task_name
        puts %Q{%s: добавлена задача "%s". Всего в списке задач: %i} %
              [@name, task_name, @tasklist.count]
      else
        raise ArgumentError, "Слишком много работы!"
      end
    rescue ArgumentError
      puts "#{@name}: слишком много работы!"
    end
  end

  def tasks
    @tasklist.map.each_with_index{|val, i| "#{i+1}. #{val}"}
  end

  def work!
    begin
      raise ArgumentError, "Нечего делать!" if @tasklist.empty?
      puts %Q{%s: %s "%s". Осталось задач: %i} %
            [@name, self.class::PHRASE, @tasklist.slice!(0), @tasklist.count]
    rescue ArgumentError
      puts "#{@name}: нечего делать!"
    end
  end

  def status
    if can_work?
      can_add_task? ? (puts "работаю") : (puts "занят")
    else 
      puts "свободен"
    end
  end

  def can_add_task?
    @tasklist.count < self.class::MAX_TASKS
  end

  def can_work?
    @tasklist.count > 0
  end
end

class JuniorDeveloper < Developer
  MAX_TASKS = 5
  PHRASE    = "пытаюсь делать задачу"

  def add_task(task_name)
    begin
      raise ArgumentError, "Слишком сложно!" if task_name.length > 20
      super
    rescue ArgumentError
      puts "#{@name}: cлишком сложно!"
    end
  end
end

class SeniorDeveloper < Developer
  MAX_TASKS = 15

  def work!
    if rand(2) == 0
      super
      unless @tasklist.empty?
        super
      end
    else
      puts "Что-то лень"
    end
  end
end