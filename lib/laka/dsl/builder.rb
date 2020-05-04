module Laka::Dsl
  class Builder
    include Evaluator
    include Syntax

    attr_reader :resources
    def initialize(deployment, blueprint_root)
      @deployment, @blueprint_root = deployment, blueprint_root
      @resources = []
    end

    def build
      # TODO: fail if resources.rb doesnt exist
      evaluate
      content = YAML.dump(template).gsub("---\n", '')
      puts "content:"
      puts content
      write(content)
      content

      # test
      # File.read("#{@blueprint_root}/resources.yaml")
    end

    def template
      {"resources" => @resources.map(&:deep_stringify_keys)}
    end

    def write(content)
      path = "output/#{@deployment}/resources.yml"
      FileUtils.mkdir_p(File.dirname(path))
      IO.write(path, content)
    end

    def evaluate
      path = "#{@blueprint_root}/resources.rb"
      puts "path #{path}"
      evaluate_file(path)
    end
  end
end
