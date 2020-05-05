class Laka::Dsl::Builder
  class Base
    include Evaluator
    include Common::Syntax

    attr_reader :resources
    def initialize(deployment, blueprint_root, path)
      @deployment, @blueprint_root, @path = deployment, blueprint_root, path
      @resources = []
    end
  end
end
