module Laka::Dsl
  class Builder
    include Evaluator
    include Syntax

    attr_reader :resources
    def initialize(blueprint_root)
      @blueprint_root = blueprint_root
      @resources = []
    end

    def build
      File.read("#{@blueprint_root}/resources.yaml")
    end

    def evaluate
      path = "#{@blueprint_root}/resources.rb"
      puts "path #{path}"
      evaluate_file(path)
    end
  end
end
