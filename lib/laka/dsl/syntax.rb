module Laka::Dsl
  module Syntax
    include Laka::Config::Defaults

    def resource(name, type, props={})
      props = Expander::Compute::Instance.new(props).expand
      resource = {
        name: name,
        type: type,
        properties: props
      }
      @resources << resource
    end
  end
end
