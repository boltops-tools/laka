module Laka
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "deploy DEPLOYMENT", "Deploy"
    long_desc Help.text(:deploy)
    def deploy(deployment)
      Deploy.new(options.merge(deployment: deployment)).run
    end

    desc "generate DEPLOYMENT", "Generate"
    long_desc Help.text(:generate)
    def generate(deployment)
      Generate.new(options.merge(deployment: deployment)).run
    end

    desc "resources DEPLOYMENT", "resources"
    long_desc Help.text(:deploy)
    def resources(deployment)
      Resources.new(options.merge(deployment: deployment)).run
    end

    desc "completion *PARAMS", "Prints words for auto-completion."
    long_desc Help.text(:completion)
    def completion(*params)
      Completer.new(CLI, *params).run
    end

    desc "completion_script", "Generates a script that can be eval to setup auto-completion."
    long_desc Help.text(:completion_script)
    def completion_script
      Completer::Script.generate
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
