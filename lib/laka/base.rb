module Laka
  class Base
    include Laka::Config::Defaults
    include GcpServices
    extend Memoist

    def initialize(options={})
      @options = options
      @deployment = @options[:deployment]
    end

    def gcloud(command)
      command = "gcloud deployment-manager deployments #{command}"
      puts "=> #{command}"

      dir = "output/blueprints/#{@deployment}"
      puts "Within dir: #{dir}"
      Dir.chdir(dir) do
        success = system(command)
        exit $?.exitstatus unless success
      end
    end
  end
end
