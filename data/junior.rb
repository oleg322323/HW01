class JuniorDeveloper < Developer
  MAX_TASKS = 5
  PHRASE    = "пытаюсь делать задачу"
  GROUP     = :juniors

  def add_task(task_name)
    raise ArgumentError, "Слишком сложно!" if task_name.length > 20
    super
  end
end
