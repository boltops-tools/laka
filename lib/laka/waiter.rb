module Laka
  class Waiter < Base
    def initialize(operation)
      @operation = operation
    end

    def run
      puts "Waiting for update: #{@operation.name}"
      until @operation.status == "DONE" do
        @operation = deployment_manager.get_operation(project, @operation.name)
        print '.'
        sleep 1
      end
      puts "Opeartion complete."
    end
  end
end
