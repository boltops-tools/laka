module Laka::Dsl::Builder::Syntax
  module Config
    def import(*templates)
      templates.flatten!
      templates.each do |template|
        import_template(template)
      end
    end

    def import_template(template)
      @template_imports << {path: template}
    end

    def resource(*list)
      list.flatten
      @template_resources += list
    end
  end
end
