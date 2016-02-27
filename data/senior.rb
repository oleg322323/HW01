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
