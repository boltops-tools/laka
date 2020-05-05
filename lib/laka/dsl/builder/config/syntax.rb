class Laka::Dsl::Builder::Config
  module Syntax
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