class Laka::Dsl::Builder
  class Config < Base
    include Syntax::Config

    attr_reader :imports
    def initialize(*)
      super
      @imports = []
    end

    # File.read("#{@blueprint_root}/config.yaml") # for testing
    def build
      evaluate_file(@path)
      content = build_content
      write(content)
      content
    end

    def build_content
      template = {"resources" => @resources.map(&:deep_stringify_keys)}
      YAML.dump(template).gsub("---\n", '')
    end

    def write(content)
      yaml_file = @path.sub('.rb','.yaml')
      path = "output/#{@deployment}/#{yaml_file}"
      FileUtils.mkdir_p(File.dirname(path))
      IO.write(path, content)
      puts "Ouput written to #{path}" unless ENV['LAKA_TEST']
    end
  end
end
