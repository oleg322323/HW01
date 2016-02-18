class Developer
  attr_reader :name, :tasklist
  @@MAX_TASKS = 10

  def initialize(name)
    @name     = name
    @tasklist = []
  end

  def add_task(task_name)
    begin
      raise ArgumentError, "Слишком много работы!" if @tasklist.count == @@MAX_TASKS
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
      puts "#{@name}: выполнена задача \"#{@tasklist.slice!(0)}\". Осталось задач: #{@tasklist.count}"
    rescue ArgumentError
      puts "#{@name}: нет задач!"
    end
  end

  def status
    case @tasklist.count
      when 0
        puts "свободен"
      when @@MAX_TASKS
        puts "занят"
      else
        puts "работаю"
    end
  end

  def can_add_task?
    !(@tasklist.count == @@MAX_TASKS)
  end

  def can_work?
    @tasklist.count != 0
  end
end