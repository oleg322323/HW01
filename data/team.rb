class Team
  attr_reader :priorities, :task_action

  def initialize(&block)
    @devs        = [] #массив экземпляров
    @priorities  = [] #массив групп разработчиков, индекс=приоритет
    @task_action = {} #хэш для блоков метода on_task
    instance_eval(&block)
  end

  def add_task(task, *args)
    if args.empty?
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
      args = args[0] #хеш идёт первым элементом

      unless args[:complexity].nil? #только группа
        dev = @devs.detect { |i| 
          i.class::GROUP == dev_type_plural(args[:complexity])
        }
      end
      unless args[:to].nil? #только имя
        dev = @devs.detect { |i|
          i.name == args[:to]
        }
      end

      unless dev.nil? #разработчик выбран
        add_task_direct(dev, task) if dev.can_add_task?
      else
        raise ArgumentError, "Такого разработчика нет!"
      end
    end
  end

  def report
    puts dev_sort.map { |i|
      %Q{%s (%s): %s} % [i.name, group_name(i), i.tasklist.join(', ')]
    }.join("\n")
  end

  def all
    @devs
  end

  #developers, juniors, seniors
  def method_missing(name, *args)
    unless @priorities.detect{ |i| i == name}.nil? #ищем любой тип разработчика
      @devs.select{ |i| i.class::GROUP == name }   #если есть, вернуть список
    else                                           #иначе стандартное исключение
      raise NoMethodError, "undefined method '#{name}' for #{self}"
    end
  end


  private

  #методы блока-конструктора
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

  def on_task(dev, &block)
    @task_action[dev_type_plural(dev)] = block
  end

  #остальные
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

  def dev_type_plural(dev) #костыль с множественным числом
    (dev.to_s + 's').to_sym
  end

  def group_name(dev) #для красивенького вывода в report
    dev.class::GROUP.to_s.chop! #вернёт строку!
  end

  def add_task_direct(dev, task)
    block = @task_action[dev.class::GROUP]
    block.call(dev, task) unless block.nil?
    dev.add_task(task)
  end
end
