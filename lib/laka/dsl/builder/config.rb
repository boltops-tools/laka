class Laka::Dsl::Builder
  class Config < Base
    include Syntax::Config

    attr_reader :imports
    def initialize(*)
      super
      @template_imports = []
    end

    def template
      # Add .jinja extension
      imports = @template_imports.map do |v|
        v.include?(".jinja") ? v : "#{v}.jinja"
      end
      resources = @template_resources.map do |h|
        type = h[:type]
        h[:type] = "#{type}.jinja" unless type.include?('.jinja')
        h
      end

      resources = resources.map(&:deep_stringify_keys)
      {
        "imports" => imports,
        "resources" => resources,
      }
    end
  end
end
