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

title 'Running a well formed query object to get data'

class Querying
  include Initializer

  initializer :connection_builder

  def run(query)
    query.run(connection_builder.create)
    query
  end


  module Proofs
    def established_connection?
      connection_builder.received(:create)
    end

    def ran?(query)
      query.received(:run, arg_match.not_nil)
    end
  end
end

class CompositeQuery
  include Initializer

  initializer :first, :second

  def !
    first.run
    second.run
    self
  end
end


proof do
  connection_builder = fake
  sut = Querying.new(connection_builder)
  query = fake

  sut.run(query)

  desc 'Creates a connection to the database'
  sut.prove { established_connection? }

  desc 'Tells the query to run using the provided connection'
  sut.prove { ran?(query) }

  desc 'Returns the query object'
  result.prove { eql? query }
end
