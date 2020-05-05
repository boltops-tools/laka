module Laka::Dsl
  class Builder
    def initialize(deployment, blueprint_root, path)
      @deployment, @blueprint_root, @path = deployment, blueprint_root, path
    end

    def self.build_all(deployment, blueprint_root)
      Dir.glob("#{blueprint_root}/**/*.rb").each do |full_path|
        next unless File.file?(full_path)
        path = full_path.sub("#{blueprint_root}/", '')
        builder = new(deployment, blueprint_root, path)
        builder.build
      end
    end
  end
end
