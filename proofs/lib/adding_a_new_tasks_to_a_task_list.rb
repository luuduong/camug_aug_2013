require_relative '../proofs_init'

title 'Adding Tasks'


module TaskList
  class Tasks
    module Proof
      def includes_task?(task)
        @tasks.include?(task)
      end

      def task_count?(number)
        @tasks.count == number
      end
    end
  end
end

proof 'Adding a new task to a task list' do
  sut = TaskList::Tasks.new
  task = TaskList::Task.new

  sut.add(task)

  desc 'The task should be added to the list of tasks'
  sut.prove { includes_task?(task) }

  desc 'The task list should only have one item'
  sut.prove { task_count?(1) }
end

proof 'Adding an existing task to a task list' do
  sut = TaskList::Tasks.new
  task = TaskList::Task.new

  sut.add(task)
  sut.add(task)

  desc 'Should not add the task again to the list of things to complete'
  sut.prove { task_count?(1) }
end


title 'Fetch a list of people from the database'

class Person
  include Initializer

  initializer :name, :age, :birthdate
end










