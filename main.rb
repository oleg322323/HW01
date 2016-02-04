if ARGV.size == 4 #защита от дурака
  (x_main, y_main, x_user, y_user) = ARGV #массив в переменные

  if x_main == x_user && y_main == y_user
  	puts "Точка найдена!"
  elsif x_main == x_user
  	puts "х координата верна, y нет"
  elsif y_main == y_user
  	puts "y координата верна, x нет"
  else
  	puts "Близко, но нет"
  end

else
	puts "Вы ввели #{ARGV.size} значений, а скрипт принимает только 4"
end
