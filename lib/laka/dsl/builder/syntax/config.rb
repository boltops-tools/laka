module Laka::Dsl::Builder::Syntax
  module Config
    def import(*templates)
      templates.flatten!
      templates.each do |template|
        import_template(template)
      end
    end

    def import_template(template)
      @imports << template
    end
  end
end