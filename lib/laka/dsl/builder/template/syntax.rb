class Laka::Dsl::Builder::Template
  module Syntax
    def resource(name, type, props={})
      props = expand(type, props)
      resource = {
        name: name,
        type: type,
        properties: props
      }
      @resources << resource
    end

    # props = Expander::Compute::Instance.new(props).expand
    def expand(type, props)
      klass = expander_class(type)
      if klass
        klass.new(props).expand # IE: Laka::Dsl::Expander::Compute::Instance.new(props).expand
      else
        props
      end
    end

    def expander_class(type)
      product, _, resource = type.split('.').map(&:camelize) # compute.v1.network
      klass = "Laka::Dsl::Builder::Expander::#{product}::#{resource}"
      klass.constantize rescue nil
    end
  end
end