module Laka::Dsl::Builder::Syntax
  module Template
    def resource(name, type, props={})
      props = expand(type, props)
      resource = {
        name: name,
        type: adjust_type(type),
      }
      resource[:properties] = props unless props.empty?
      @template_resources << resource
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

    def adjust_type(type)
      type.include?('.') ? type : "#{type}.jinja"
    end
  end
end
