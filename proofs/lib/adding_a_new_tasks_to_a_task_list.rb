require_relative '../proofs_init'

title 'Adding Tasks'

proof 'Adding a new task to a task list' do
  sut = TaskList::Tasks.new
  task = TaskList::Task.new

  sut.add(task)

  desc 'The task should be added to the list of tasks'
  sut.prove { @tasks.include? task }

  desc 'The task list should only have one item'
  sut.prove { @tasks.count == 1 }
end

proof 'Adding an existing task to a task list' do
  sut = TaskList::Tasks.new
  task = TaskList::Task.new

  sut.add(task)
  sut.add(task)

  desc 'Should not add the task again to the list of things to complete'
  sut.prove { @tasks.count == 1 }
end
