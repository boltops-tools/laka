class Laka::Dsl::Builder
  class Base
    include Evaluator
    include Syntax::Common

    attr_reader :template_resources
    def initialize(deployment, blueprint_root, path)
      @deployment, @blueprint_root, @path = deployment, blueprint_root, path
      @template_resources = []
    end

    # File.read("#{@blueprint_root}/config.yaml") # for testing
    def build
      evaluate_file(@path)
      content = build_content
      write(content)
      content
    end

    def build_content
      YAML.dump(template).gsub("---\n", '')
    end

    def write(content)
      yaml_file = @path.sub('config.rb', 'config.yaml').sub('.rb','.jinja').sub('app/','')
      path = "output/#{yaml_file}"
      FileUtils.mkdir_p(File.dirname(path))
      IO.write(path, content)
      puts "Ouput written to #{path}" unless ENV['LAKA_TEST']
    end
  end
end
