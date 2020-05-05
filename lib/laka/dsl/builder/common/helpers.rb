module Laka::Dsl::Builder::Common
  module Helpers
    def env(key)
      "{{ env['#{key}'] }}"
    end

    def properties(key)
      "{{ properties['#{key}'] }}"
    end

    def ref(key)
      "$(ref.#{key}.selfLink)"
    end
  end
end
