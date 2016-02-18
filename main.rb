require 'pry'
require_relative "data/class.rb"

dev = Developer.new('Вася')
p dev.can_work?

dev.status
dev.add_task('Полить кактус')
dev.add_task('Вынести мусор')
dev.add_task('Сходить в магазин')
dev.status
p dev.can_work?

dev.add_task('Полить кактус')
dev.add_task('Вынести мусор')
dev.add_task('Сходить в магазин')
dev.add_task('Полить кактус')
dev.add_task('Вынести мусор')
dev.add_task('Сходить в магазин')
dev.add_task('Полить кактус')
dev.add_task('Вынести мусор')
dev.add_task('Сходить в магазин')
dev.status
p dev.can_add_task?
#dev.tasks
#dev.work!

#binding.pry


