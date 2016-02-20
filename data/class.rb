class Developer
  MAX_TASKS = 10
  PHRASE    = "выполнена задача"

  def initialize(name)
    @name     = name
    @tasklist = []
  end

  def add_task(task_name)
    begin
      raise ArgumentError, "Слишком много работы!" if @tasklist.count == self.class::MAX_TASKS
      @tasklist << task_name
      puts "#{@name}: добавлена задача \"#{task_name}\". Всего в списке задач: #{@tasklist.count}"
    rescue ArgumentError
      puts "#{@name}: слишком много работы!"
    end
  end

  def tasks
    @tasklist.each_with_index{|val, i| puts "#{i+1}. #{val}"}
  end

  def work!
    begin
      raise ArgumentError, "Нечего делать!" if @tasklist.count == 0
      puts "#{@name}: #{self.class::PHRASE} \"#{@tasklist.slice!(0)}\". Осталось задач: #{@tasklist.count}"
    rescue ArgumentError
      puts "#{@name}: нечего делать!"
    end
  end

  def status
    case @tasklist.count
      when 0
        puts "свободен"
      when self.class::MAX_TASKS
        puts "занят"
      else
        puts "работаю"
    end
  end

  def can_add_task?
    @tasklist.count != self.class::MAX_TASKS
  end

  def can_work?
    @tasklist.count != 0
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
      if @tasklist.count > 0 #если остались задачи, делаем еще одну
        super
      end
    else
      puts "Что-то лень"
    end
  end
end