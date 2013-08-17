module TaskList
  class Tasks
    def initialize()
      @tasks = []
    end

    def add (task)
      
      @tasks << task unless @tasks.include? task
    end
  end
end
