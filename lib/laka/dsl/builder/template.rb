class Laka::Dsl::Builder
  class Template < Base
    include Syntax::Template

    def template
      {
        "resources" => @template_resources.map(&:deep_stringify_keys)
      }
    end
  end
end
