require_relative "data/developer.rb"
require_relative "data/junior.rb"
require_relative "data/senior.rb"
require_relative "data/team.rb"


team = Team.new do
  # создаём команду, описываем её в этом блоке

  # описываем, какие в команде есть разработчики
  have_seniors "Олег", "Оксана"
  have_developers "Олеся", "Василий", "Игорь-Богдан"
  have_juniors "Владислава", "Аркадий", "Рамеш"

  # описываем в каком порядке выдавать задачи:
  # * сначала любому джуниору
  # * потом любому обычному разработчику
  # * потом любому старшему
  priority :juniors, :developers, :seniors

  # on_task :developers do |dev, task|
  #   puts %Q{Разработчик %s выполняет задачу %s} %
  #         [dev.name, task]
  # end
  # описываем дополнительные действия, когда задача выдана джуну
  on_task :junior do |dev, task|
    puts %Q{Отдали задачу %s разработчику %s, следите за ним!} %
          [task, dev.name]
  end

  # ...и так можно для любого типа разработчиков описать, например:
  on_task :senior do |dev, task|
    puts %Q{%s сделает %s, но просит больше с такими глупостями не приставать} %
          [dev.name, task]
  end
end

# p team.seniors
# p team.developers
# p team.juniors
# p team.all

10.times{
  team.add_task 'Обычная задача'
}

team.report
team.add_task 'Сложная задача', complexity: :senior, to: 'Василий'
team.report










# dev = Developer.new('Вася')
# p dev.class::GROUP
# p dev.can_work?

# puts dev.status
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.status
# p dev.can_work?

# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.status
# p dev.can_add_task?
# puts dev.tasks
# puts dev.status
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# dev.work!
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.tasks

# dev = JuniorDeveloper.new('Петя')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.status
# dev.add_task('Сходить в магазин и купить хлеба и молока')
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.status
# dev.work!
# dev.work!
# dev.work!
# dev.work!
# dev.work!
# dev.work!


# dev = SeniorDeveloper.new('Степан')
# puts dev.status
# dev.add_task('Полить кактус')
# dev.add_task('Вынести мусор')
# dev.add_task('Сходить в магазин')
# puts dev.tasks
# puts dev.status
# dev.work!
# dev.work!
# dev.work!
# dev.work!
# dev.work!
# dev.work!