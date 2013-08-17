module TaskList
  class Tasks
    def initialize()
      @tasks = []
    end

    def add (task)
      @tasks << task
    end
  end
end
