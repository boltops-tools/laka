module Laka::Dsl
  module Syntax
    def resource(name, type, props={})
      resource = {
        name: name,
        type: type,
        properties: props
      }
      @resources << resource
    end
  end
end
