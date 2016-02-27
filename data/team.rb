class Team
  attr_reader :priorities, :task_action

  def initialize(&block)
    @devs  = [] #если в команде небудет опр. вида разработчиков
    @priorities  = [] #массив приоритетов
    @task_action = {} #хэш для блоков метода on_task
    instance_eval(&block)
  end

  def add_task(task, *args)
    if args == []
      #реализация для хорошей сортировки
      # dev = dev_sort.slice(0)
      # if dev.can_add_task?
      #   add_task_direct(dev, task)
      # else
      #   #если нельзя добавить первому, то всем остальным тоже
      #   raise ArgumentError, "Вся команда занята!"
      # end

      #для обычной сортировки
      dev_list = dev_sort()
      begin #листаем девелоперов пока не кончатся
        dev = dev_list.slice!(0)
        if dev.can_add_task?
          add_task_direct(dev, task)
          break
        end
      end until dev_list.empty?
    else #есть аргументы
      unless args[:to].nil? #только имя
        dev = @devs.detect { |i| i.name == args[:to] }
      end
      unless args[:complexity].nil? #только группа
        dev = @devs.detect { |i| i.class::GROUP == args[:complexity] }
      end

      unless dev.nil?
        add_task_direct(dev, task) if dev.can_add_task?
      else
        raise ArgumentError, "Такого разработчика нет!"
      end
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
    puts dev_sort.map { |i|
      %Q{%s (%s): %s} % [i.name, group_name(i), i.tasklist.join(', ')]
    }.join("\n")
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

  def on_task(dev_type_singular, &block)
    #костыль с множественным числом
    dev_type_plural = (dev_type_singular.to_s + 's').to_sym
    #блок кода в массив
    @task_action[dev_type_plural] = block
  end

  def dev_sort
    #хорошая сортировочка, с задвиганием в конец занятых
    # @devs.sort_by do |i|
    #   #модификатор опыта (джун 0, дев 1, сен 2)
    #   m = @priorities.find_index(i.class::GROUP)
    #   #приоритет, по которому отсортирует (задача = 3 пункта приоритета)
    #   prio = i.tasklist.count * @priorities.count + m
    #   #если занят, то в конец списка
    #   prio += 100 unless i.can_add_task?
    #   #сортировать по этому значению (после += плохо возвращать)
    #   prio
    # end

    #обычная
    @devs.sort_by do |i|
      [i.tasklist.count, @priorities.find_index(i.class::GROUP)]
    end
  end

  def group_name(dev)
    dev.class::GROUP.to_s.chop!
  end

  def add_task_direct(dev, task)
    block = @task_action[dev.class::GROUP]
    block.call(dev, task) unless block.nil?
    dev.add_task(task)
  end
end
